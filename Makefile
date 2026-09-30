# Setup otomatis untuk komputer baru.
#   make check  — lihat apa yang kurang (paket, monitor, wallpaper) tanpa mengubah apa pun
#   make deps   — install paket yang belum terpasang
#   make env    — sesuaikan env (monitor, env.conf, direktori) dengan mesin ini
#   make setup  — deps + env (default)

.PHONY: check deps env setup

setup: deps env
	@echo "[make] Setup selesai."

check:
	./setup.sh check

deps:
	./setup.sh deps

env:
	./setup.sh env