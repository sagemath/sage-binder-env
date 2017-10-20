A SageMath-based computing environment for binder
=================================================

.. image:: https://beta.mybinder.org/badge.svg
   :target: https://beta.mybinder.org/v2/gh/sagemath/sage-binder-env/master?filepath=index.ipynb

This repository illustrates Binder use cases for
`SageMath <http://sagemath.org>`_.

.. TOPIC:: What is `Binder <http://mybinder.org>`_?

    Have a repository full of Jupyter notebooks? With `Binder
    <http://mybinder.org>`_, you can add a badge that opens those
    notebooks in an executable environment, making your code
    immediately reproducible by anyone, anywhere.

.. TOPIC:: What is `SageMath <http://sagemath.org>`_?

    A general purpose, community developed open source software for
    computational mathematics.

Demo notebooks
--------------

This repository provides some simple live demos for SageMath and other
software included in the SageMath distribution.

- `index.ipynb <index.ipy>`_: starter notebook / brief SageMath demo
- `demo-gap.ipynb <demo-gap.ipynb>`_: brief GAP demo
- `demo-pari.ipynb <demo-pari.ipynb>`_: brief Pari/GP demo
- `demo-singular.ipynb <demo-singular.ipynb>`_: brief Singular demo

.. TOPIC:: TODO

    Develop a collection of striking demo notebooks, and link from
    `http://sagemath.org/`, maybe as try.sagemath.org.

Example of binder-enabled repository for SageMath
-------------------------------------------------

Have a repository full of Jupyter notebooks using SageMath? It's easy
to setup Binder to let anyone run them. Just copy the short
`Dockerfile <Dockerfile>`_ from this repository, and adapt it to your needs. You
probably also want to insert the Binder badge in your `README`.

## Computing backend for live documents (Thebe)

Have HTML pages (e.g. documentation) containing chunks of Sage code?
With `Thebe <https://github.com/minrk/thebelab>`_, it's easy to turn
them into live code cells that will use Binder and the executable
environment defined by this repository.

See this `Thebe example <https://minrk.github.io/thebelab/prompts.html>`_.

For the Sphinx-generated documentation of a SageMath based project,
you can use the Sphinx extension provided by the
`Sage package authoring utilities <https://github.com/sagemath/sage-package>`_.
For an example, see the
`short graphics demo <http://more-sagemath-tutorials.readthedocs.io/en/latest/mocksage/plot/demo.html>`_
of
`More SageMath tutorials <http://more-sagemath-tutorials.readthedocs.io/>`_,
and click `Activate`.

Note: `Thebe` is similar in principle to `SageMath Cell <http://sagecell.sagemath.org/>`_.
It introduces additional flexibility by enabling the customization of
the programming language (kernel), computing backend (e.g. local
Jupyter server, ...) and executable environment (e.g. via Binder).
It also targets a much broader community, with the potential to
relieve the SageMath community from maintaining a custom solution.
On the other hand it's still relatively recent and quickly evolving
technology with less settled sustainability.

Authors
-------

Nicolas M. Thiéry

The demo notebooks for GAP, Singular, and Pari were written by the
authors of the respective kernels. See the
`report on their implementation <https://github.com/OpenDreamKit/OpenDreamKit/tree/master/WP4/D4.4>`_.

Contributions most welcome!
