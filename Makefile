CONFIG_FILE := ~/.bashrc

target:
	make setup-python-env

setup-pyenv:
	sudo apt install python3-pip
	curl https://pyenv.run | bash
	echo 'export PYENV_ROOT="$$HOME/.pyenv"' >> $(CONFIG_FILE)
	echo 'command -v pyenv >/dev/null || export PATH="$$PYENV_ROOT/bin:$$PATH"' >> $(CONFIG_FILE)
	echo 'eval "$$(pyenv init -)"' >> $(CONFIG_FILE)
	pyenv install 3.10.10
	pyenv global 3.10.10

setup-pyenv-virtualenvwrapper: setup-pyenv
	git clone https://github.com/pyenv/pyenv-virtualenvwrapper.git ~/.pyenv/plugins/pyenv-virtualenvwrapper
	echo 'export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"' >> $(CONFIG_FILE)
	echo 'export VIRTUALENVWRAPPER_PYTHON=$$PYENV_ROOT/shims/python' >> $(CONFIG_FILE)
	echo 'pyenv virtualenvwrapper' >> $(CONFIG_FILE)
	echo 'pyenv virtualenvwrapper_lazy' >> $(CONFIG_FILE)

setup-python-env: setup-pyenv-virtualenvwrapper

clean:
	rm -rf ~/.pyenv
	rm -rf ~/.local/virtualenv
