Live SageMath examples in static HTML pages with Thebe and binder
=================================================================

If you read this page, you probably followed the `About` link of some
SageMath related web page that embeds live code examples that can be
edited and executed online after clicking `Activate`. Such pages
include:

- (in the work) The SageMath's documentation, either
  `online <http://doc.sagemath.org/>`_ or locally.

- `More SageMath tutorials <https://more-sagemath-tutorials.readthedocs.io/>`_

This is handled by the `Thebe <https://github.com/minrk/thebelab>`_
javascript library, configured to run the computations on `mybinder.org
<http://mybinder.org>`_, using the latest version of `SageMath
<http://sagemath.org>`_. See below for some background on those tools.
This is meant for casual use; as for any cloud-based service, don't
run calculations that could leak private information. See the
`binder faq <https://mybinder.readthedocs.io/en/latest/faq.html>`_ for details.

`Thebe <https://github.com/minrk/thebelab>`_ is a small javascript
library based on `JupyterLab <http://jupyterlab.readthedocs.io/en/latest/>`_
that enables embedding live code examples in an HTML page. Upon
clicking `Run`, the code is sent to a Jupyter server for execution and
the result displayed back.

`Binder <https://mybinder.readthedocs.io/>`_ is a free and open source
service for temporary computations within an arbitrary execution
environment; `mybinder.org <mybinder.org>`_ is binder's original
instance.

`SageMath <http://sagemath.org>`_ is a general purpose open source
software for mathematical computations.

See also the `README <README.rst>`_ for some more on how to set up
this service on your own web pages.
