# test-binder: Testing binder services for deploying mini form-based web services for earth sciences

A code sprint with a friend from earth sciences to test technologies
like Jupyter, ipywidgets, binder & friends to make computational code
trivially accessible to end-user through a mini form-based web-app.

[![Binder](http://mybinder.org/badge.svg)](http://mybinder.org:/repo/nthiery/test-binder/)

## Authors

Tamir Kamai and Nicolas M. Thiéry

## Demonstrator notebooks

- [minimal.ipynb](minimal.ipynb): an interact-based minimal web-app
- [file_upload_example.ipynb](file_upload_example.ipynb): same, with a file upload widget
- [application.ipynb](application.ipynb): a more complete widget-based web-app

## References

- https://mybinder.org
- https://ipywidgets.readthedocs.io/en/latest/examples/Using%20Interact.html#
- https://ipython.readthedocs.io/en/stable/interactive/plotting.html
- https://blog.dominodatalab.com/interactive-dashboards-in-jupyter/

## Local installation

    sudo apt install python3-pip
    sudo pip3 install --upgrade --user pip   # Not necessarily needed
    sudo pip3 install --user -e .

May be needed:

    jupyter nbextension enable --py widgetsnbextension
    python3 -m ipykernel install --user

## Running tests

For now:

    python -m doctest temp_codes/ls_5.py   # same for friends

## Future work

### Bugs

- [ ] ipywidgets are currently broken on mybinder.org: This should be
      fixed soon. Otherwise, report!

### Features

- [X] Simple workflow manager: input type / processing / output:
      Could be abstracted away

- [ ] Widgets to upload / download data:
      Done for loading

- [ ] Automatic execution of the notebook:
      Comment by Min: this not yet implemented; it should be easy to
      implement this. Of course this would only be activated for
      trusted notebooks; that's fine since binder trusts all notebooks
      by default.

- [ ] Hiding of the code:
      This feature will be easier to implement with
      JupyterLab. Hopefuly to come in the coming year. For now, the
      best would be to put all the code in Python files, and just have
      a trivial notebook with just "from app import App; App().run()".

- [ ] Types for the input: done experimentaly

### Potential design

TODO
