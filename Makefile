.PHONY: help clean clean-pyc clean-build build list test test-all coverage release sdist

help:
	@echo "clean-build - remove build artifacts"
	@echo "clean-pyc - remove Python file artifacts"
	@echo "lint - check style with flake8"
	@echo "test - run tests quickly with the default Python"
	@echo "test-all - run tests on every Python version with tox"
	@echo "build-readme - build the readme file"
	@echo "bump-and-push - run tests, lint, bump patch, push to git, and release on pypi"
	@echo "coverage - check code coverage quickly with the default Python"
	@echo "release - package and upload a release"
	@echo "sdist - package"
	@echo "cleanup-pep8 - automatical clean up some linting violations"

clean: clean-build clean-pyc

clean-build:
	rm -fr build/
	rm -fr dist/
	rm -fr *.egg-info

clean-pyc:
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +

build-readme:
	pandoc README.md --to=RST > README.rst

lint:
	flake8 bupper test

test:
	py.test

test-all:
	tox

coverage:
	coverage run --source bupper setup.py test
	coverage report -m
	coverage html
	open htmlcov/index.html

bump-and-push: test lint build-readme
	bumpversion patch
	git push
	git push --tags
	make release

build: clean
	python3 setup.py sdist
	python3 setup.py bdist_wheel

cleanup-pep8:
	autoflake --in-place --remove-all-unused-imports --remove-unused-variables -r bupper
	autoflake --in-place --remove-all-unused-imports --remove-unused-variables -r test
	autopep8 --in-place -r bupper
	autopep8 --in-place -r test

release: clean
	python3 setup.py sdist upload
	python3 setup.py bdist_wheel upload

sdist: clean
	python3 setup.py sdist
	python3 setup.py bdist_wheel upload
	ls -l dist
