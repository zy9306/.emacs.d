#!/usr/bin/env python3

import os
import shutil
import ssl
import tarfile
import urllib.request
import zipfile
from contextlib import contextmanager
from pathlib import Path

ssl._create_default_https_context = ssl._create_unverified_context

base_url = "https://github.com/emacs-tree-sitter"

langs = (
    f"{base_url}/tree-sitter-langs/"
    "releases/download/{version}/tree-sitter-grammars-{os}-{version}.tar.gz"
)

dyn = (
    f"{base_url}/elisp-tree-sitter/"
    "releases/download/{version}/tsc-dyn.{suffix}"
)

os_to_suffix = {
    "linux": "so",
    "macos": "dylib",
    "windows": "dll",
}

cwd = Path(os.getcwd())

tmp_dir = Path("tmp")
shutil.rmtree(tmp_dir, ignore_errors=True)
if not tmp_dir.exists():
    tmp_dir.mkdir(exist_ok=True)

dyn_dir = tmp_dir.joinpath("dyn")
if not dyn_dir.exists():
    dyn_dir.mkdir(exist_ok=True)

langs_dir = tmp_dir.joinpath("langs")
if not langs_dir.exists():
    langs_dir.mkdir(exist_ok=True)


@contextmanager
def chdir(path, mkdir=False):
    if mkdir:
        Path(path).mkdir(parents=True, exist_ok=True)
    os.chdir(path)
    try:
        yield path
    finally:
        os.chdir(cwd)


def download(url, dir_, file_name=None):
    dir_ = Path(dir_)
    if not dir_.exists():
        dir_.mkdir(parents=True)

    if file_name is None:
        file_name = url.split("/")[-1]

    with urllib.request.urlopen(url) as f, chdir(dir_), open(
        file_name, "wb"
    ) as fw:
        fw.write(f.read())


def unzip(file, dir_):
    with zipfile.ZipFile(file) as z, chdir(dir_, mkdir=True):
        z.extractall()


def extract_tarfile(file, dir_):
    with tarfile.open(file) as tf, chdir(dir_, mkdir=True):
        tf.extractall()


def get_ts_version():
    with urllib.request.urlopen(
        (
            "https://raw.githubusercontent.com/emacs-tree-sitter/"
            "elisp-tree-sitter/master/core/tsc.el"
        )
    ) as f:
        while True:
            line = f.readline().decode()
            if line.startswith(";; Version:"):
                return line.split()[-1]


def get_langs_version():
    with urllib.request.urlopen(
        (
            "https://raw.githubusercontent.com/emacs-tree-sitter/"
            "tree-sitter-langs/master/tree-sitter-langs.el"
        )
    ) as f:
        while True:
            line = f.readline().decode()
            if line.startswith(";; Version:"):
                return line.split()[-1]


def fetch_langs():
    version = get_langs_version()
    for os_ in os_to_suffix.keys():
        url = langs.format(version=version, os=os_)
        file = url.split("/")[-1]
        print(f"Start download: {file}")
        download(url, langs_dir, file)
        print(f"Finish download, location: {langs_dir}\n")
        with chdir(langs_dir):
            extract_path = f"{os_}/bin"
            print(f"Start extract: {file} to {os_}")
            extract_tarfile(file, extract_path)
            print(
                (
                    f"Finished extract\n"
                    f"location: {langs_dir.joinpath(extract_path)}\n"
                )
            )
            os.remove(langs_dir.joinpath(file))


def fetch_dyn():
    version = get_ts_version()
    for suffix in os_to_suffix.values():
        url = dyn.format(version=version, suffix=suffix)
        print(f"Start download: {url}")
        download(url, dyn_dir, url.split("/")[-1])
        print(f"Finish download, location: {dyn_dir}\n")
    with open(dyn_dir.joinpath("DYN-VERSION"), "w") as f:
        f.write(version)


def fetch_elisp():
    print("Start download elisp\n")
    file = "master.zip"
    dir_ = "elisp-tree-sitter-master"
    final_dir_ = "elisp-tree-sitter"
    download(
        "https://github.com/emacs-tree-sitter/elisp-tree-sitter/"
        "archive/refs/heads/master.zip",
        tmp_dir,
    )
    unzip(tmp_dir.joinpath(file), tmp_dir)
    shutil.copytree(
        tmp_dir.joinpath(f"{dir_}/lisp"), tmp_dir.joinpath(f"{final_dir_}")
    )

    for f in ["core/tsc.el", "core/tsc-obsolete.el", "core/tsc-dyn-get.el"]:
        dst = tmp_dir.joinpath(f"{final_dir_}/{f}")
        if not dst.parent.exists():
            dst.parent.mkdir()
        shutil.copyfile(tmp_dir.joinpath(f"{dir_}/{f}"), dst)

    os.remove(tmp_dir.joinpath(file))
    shutil.rmtree(tmp_dir.joinpath(f"{dir_}"), ignore_errors=True)


def fetch_elisp_langs():
    print("Start download elisp langs\n")
    file = "master.zip"
    dir_ = "tree-sitter-langs-master"
    final_dir_ = "tree-sitter-langs"
    download(
        "https://github.com/emacs-tree-sitter/"
        "tree-sitter-langs/archive/refs/heads/master.zip",
        tmp_dir,
    )
    unzip(tmp_dir.joinpath(file), tmp_dir)
    shutil.copytree(
        tmp_dir.joinpath(f"{dir_}/queries"),
        tmp_dir.joinpath(f"{final_dir_}/queries"),
    )

    for f in ["tree-sitter-langs-build.el", "tree-sitter-langs.el"]:
        shutil.copyfile(
            tmp_dir.joinpath(f"{dir_}/{f}"),
            tmp_dir.joinpath(f"{final_dir_}/{f}"),
        )

    os.remove(tmp_dir.joinpath(file))
    shutil.rmtree(tmp_dir.joinpath(f"{dir_}"), ignore_errors=True)


def main():
    fetch_elisp()
    fetch_elisp_langs()
    fetch_langs()
    fetch_dyn()

    shutil.rmtree("src", ignore_errors=True)
    shutil.move("tmp", "src")


if __name__ == "__main__":
    main()
