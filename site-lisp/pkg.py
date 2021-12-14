#!/usr/bin/env python3

import os
import json
import shutil
import subprocess
import sys
from contextlib import contextmanager
from pathlib import Path


pkg_file = "pkg.json"
load_file = "load.el"


@contextmanager
def chdir(path):
    cwd = os.getcwd()
    os.chdir(path)
    try:
        yield path
    finally:
        os.chdir(cwd)


def run_cmd(cmd_str, need_stdout=False):
    kwargs = {}
    if need_stdout:
        kwargs["stdout"] = subprocess.PIPE

    rv = subprocess.run(cmd_str.split(" "), **kwargs)
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
        ignore = pkg_info.get("ignore")
        shutil.rmtree(".git", ignore_errors=True)
        if ignore:
            for i in ignore:
                tmp_path = Path(i)
                if tmp_path.exists():
                    if tmp_path.is_dir():
                        shutil.rmtree(i, ignore_errors=True)
                    else:
                        os.remove(i)
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


def get_pkg_info(pkg_name, pkg_repo, commit):
    if pkg_name:
        with open(Path(pkg_file)) as f:
            pkg_map = json.load(f)
        if pkg_name not in pkg_map:
            raise Exception("PKG not found in pkg.json!")
        pkg_info = pkg_map[pkg_name]
        if commit:
            pkg_info[commit] = commit
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
        }


def dispatch(argv):
    action = argv.pop(0)
    if action == "add":
        repo = argv.pop(0)
        commit = argv.pop(0) if argv else None
        pkg_info = get_pkg_info(pkg_name=None, pkg_repo=repo, commit=commit)
        fetch(pkg_info)
        return

    if action == "update":
        pkg_name = argv.pop(0)
        commit = argv.pop(0) if argv else None
        pkg_info = get_pkg_info(
            pkg_name=pkg_name, pkg_repo=None, commit=commit
        )
        fetch(pkg_info)
        return

    if action == "delete":
        pkg_name = argv.pop(0)
        commit = argv.pop(0) if argv else None
        pkg_info = get_pkg_info(
            pkg_name=pkg_name, pkg_repo=None, commit=commit
        )
        delete(pkg_info)
        return

    raise Exception("No handle!")


def main():
    argv = sys.argv
    argv.pop(0)
    dispatch(argv)

    print("Done!")


if __name__ == "__main__":
    main()
