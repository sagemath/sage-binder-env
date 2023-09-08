Binder computing environment using SageMath
===========================================

.. image:: https://mybinder.org/badge_logo.svg
 :target: https://mybinder.org/v2/gh/kwankyu/sage-binder-env/master

This repository provides a `Binder <http://mybinder.org>`_ repo based on
`SageMath <http://sagemath.org>`_.


An example of binder repository for SageMath
--------------------------------------------

Have a repository full of Jupyter notebooks using SageMath? It's easy
to setup Binder to let anyone run them. Just copy the short
`Dockerfile <Dockerfile>`_ from this repository, and adapt it to your needs. You
probably also want to insert the Binder badge in your `README.rst`.


Extending the sagemath Docker image
-----------------------------------

The sample `Dockerfile` in this repository is based on the official sagemath
Docker image.  It includes Sage itself, and all the software packages typically
included in a standard Sage installation, though not *everything* (in
particular not optional Sage SPKGs, or other system software packages).

So in order to install additional Sage SPKGs it is possible to include a line like::

    RUN sage -i <spkg-name>

in the ``Dockerfile``.
