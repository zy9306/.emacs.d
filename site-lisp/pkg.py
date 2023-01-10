#!/usr/bin/env python3

import os
import json
import shutil
import argparse
import subprocess
from contextlib import contextmanager
from pathlib import Path


pkg_file = "pkg.json"
load_file = "load.el"

parser = argparse.ArgumentParser()

parser.add_argument("--add")
parser.add_argument("--delete")
parser.add_argument("--update")
parser.add_argument("--commit")
parser.add_argument("--exclude")
parser.add_argument("--ignore")
parser.add_argument("--only_el", default=False, action="store_true")

args = parser.parse_args()


@contextmanager
def chdir(path, mkdir=False, cwd=None):
    cwd_ = cwd or os.getcwd()
    if mkdir:
        Path(path).mkdir(parents=True, exist_ok=True)
    os.chdir(path)
    try:
        yield path
    finally:
        os.chdir(cwd_)


def run_cmd(cmd_str, need_stdout=False):
    kwargs = {"shell": True}
    if need_stdout:
        kwargs["stdout"] = subprocess.PIPE

    rv = subprocess.run(cmd_str, **kwargs)
    if rv.returncode != 0:
        raise

    return rv.stdout.decode() if rv.stdout else ""


def write_load(pkg_info, delete=False):
    path = Path(load_file)
    if not path.exists():
        loads = set()
    else:
        with open(path) as f:
            loads = {line.strip() for line in f.readlines() if line}

    pkg = pkg_info["pkg"]
    line = f'(push (expand-file-name "site-lisp/{pkg}" user-emacs-directory) load-path)'  # noqa
    if delete:
        if line in loads:
            loads.remove(line)
    else:
        loads.add(line)

    with open(load_file, "w") as f:
        f.write("\n".join(sorted(loads)))


def write_pkg(pkg_info, delete=False):
    path = Path(pkg_file)
    if not path.exists():
        pkg_infos = {}
    else:
        with open(path) as f:
            pkg_infos = json.load(f)

    pkg = pkg_info["pkg"]

    if delete:
        if pkg in pkg_infos:
            pkg_infos.pop(pkg)
    else:
        pkg_infos.update({pkg: pkg_info})

    with open(path, "w") as f:
        json.dump(pkg_infos, f, indent=2, sort_keys=True)


def rm_empty_dir(path):
    path = Path(path)
    items = [_ for _ in path.glob("**/*") if _.is_dir()]
    items.sort(key=lambda item: -len(str(item)))
    for item in items:
        if not [_ for _ in item.glob("**/*")]:
            print(f"remove {item}")
            shutil.rmtree(item, ignore_errors=False)


def rm_dir_or_file(path):
    path = Path(path)
    if not path.exists():
        return
    if path.is_dir():
        shutil.rmtree(path, ignore_errors=True)
    else:
        os.remove(path)


def fetch(pkg_info):
    pkg = pkg_info["pkg"]
    path = Path(pkg)
    bak_path = Path(f"{path.name}_bak")
    if path.exists() and not bak_path.exists():
        path.rename(f"{path.name}_bak")

    run_cmd(f"git clone --depth=1 {pkg_info['repo']}")

    with chdir(path):
        commit = pkg_info.get("commit")
        if commit:
            run_cmd(f"git checkout {commit}")
        else:
            out = run_cmd("git rev-parse HEAD", True)
            pkg_info["commit"] = out.split()[0]
        ignore = pkg_info.get("ignore")
        shutil.rmtree(".git", ignore_errors=True)
        if pkg_info.get("only_el"):
            for p in Path(".").glob("**/*"):
                if p.is_dir():
                    continue
                if p.suffix == ".el":
                    continue
                print(f"remove {p}")
                rm_dir_or_file(p)
            rm_empty_dir(".")

        if ignore:
            for i in ignore:
                rm_dir_or_file(i)
        else:
            pkg_info["ignore"] = []

    shutil.rmtree(bak_path, ignore_errors=True)
    write_pkg(pkg_info)
    write_load(pkg_info)


def delete(pkg_info):
    pkg = pkg_info["pkg"]
    path = Path(pkg)
    shutil.rmtree(path, ignore_errors=True)
    write_pkg(pkg_info, delete=True)
    write_load(pkg_info, delete=True)


def get_pkg_info(pkg_name, pkg_repo, commit, ignore=None, only_el=False):
    ignore = ignore.split(",") if ignore else []
    if pkg_name:
        with open(Path(pkg_file)) as f:
            pkg_map = json.load(f)
        if pkg_name not in pkg_map:
            raise Exception("PKG not found in pkg.json!")

        pkg_info = pkg_map[pkg_name]
        pkg_info["ignore"] = ignore
        pkg_info["only_el"] = pkg_info["only_el"]
        pkg_info["commit"] = commit

        return pkg_info

    if pkg_repo:
        pkg_name = pkg_repo.split("/")[-1].replace(".git", "")
        out = run_cmd(f"git ls-remote {pkg_repo}", True)
        if not commit:
            commit = out.split()[0]
        return {
            "pkg": pkg_name,
            "repo": pkg_repo,
            "commit": commit,
            "ignore": ignore,
            "only_el": only_el,
        }


def dispatch():
    if args.add:
        pkg_info = get_pkg_info(
            pkg_name=None,
            pkg_repo=args.add,
            commit=args.commit,
            ignore=args.ignore,
            only_el=args.only_el
        )
        fetch(pkg_info)
        return

    elif args.delete:
        pkg_info = get_pkg_info(
            pkg_name=args.delete,
            pkg_repo=None,
            commit=args.commit,
            ignore=args.ignore,
        )
        delete(pkg_info)
        return

    elif args.update:
        pkg_info = get_pkg_info(
            pkg_name=args.update,
            pkg_repo=None,
            commit=args.commit,
            ignore=args.ignore,
            only_el=args.only_el,
        )
        fetch(pkg_info)
        return

    else:
        print("required add or delete or update")
        return


def main():
    dispatch()


if __name__ == "__main__":
    main()
