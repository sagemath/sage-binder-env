A SageMath-based computing environment for binder
=================================================

.. image:: https://mybinder.org/badge_logo.svg
 :target: https://mybinder.org/v2/gh/sagemath/sage-binder-env/master?filepath=index.ipynb

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

Examples of binder-enabled repository for SageMath
--------------------------------------------------

Have a repository full of Jupyter notebooks using SageMath? It's easy
to setup Binder to let anyone run them. Just copy the short
`Dockerfile <Dockerfile>`_ from this repository, and adapt it to your needs. You
probably also want to insert the Binder badge in your `READ ME`.

Examples:
- `Some live slides for a talk <https://mybinder.org/v2/gh/nthiery/harmonic-modules/master?filepath=talk.ipynb>`_
- `A research paper logbook <https://mybinder.org/v2/gh/defeo/ffisom/master?filepath=notebooks>`_

Computing backend for live documents with Thebe
-----------------------------------------------

Have HTML pages (e.g. documentation) containing chunks of `SageMath <http://sagemath.org>`_ code?
With `Thebe <https://github.com/minrk/thebelab>`_, it's easy to turn
them into live code cells that will use `Binder <http://mybinder.org>`_
and the executable environment defined by this repository.

See this `Thebe example <https://minrk.github.io/thebelab/prompts.html>`_.

For the Sphinx-generated documentation of a Sage based project,
you can use the Sphinx extension provided by the
`Sage package authoring utilities <https://github.com/sagemath/sage-package>`_.
For an example, see this
`demo page <http://sage-package.readthedocs.io/en/latest/sage_package/sphinx-demo.html>`_,
and click `Activate`.

Note: `Thebe` is similar in principle to `SageMath Cell <http://sagecell.sagemath.org/>`_.
It introduces additional flexibility by enabling the customization of
the programming language (kernel), computing backend (e.g. local
Jupyter server, ...) and executable environment (e.g. via Binder).
It also targets a much broader community, with the potential to
relieve the SageMath community from maintaining a custom solution.
On the other hand it's still relatively recent and quickly evolving
technology with less settled sustainability. Also the SageMath Cell
has been optimized to be more reactive on startup and reduceapt
resource consumption. Those optimizations have not yet been ported to
Thebe+binder.

See also `thebe.rst <thebe.rst>`_ for additional reader-oriented notes.

Extending the sagemath Docker image
-----------------------------------

The sample `Dockerfile <https://github.com/sagemath/sage-binder-env/blob/master/Dockerfile>`_
in this repository is based on the official ``sagemath/sagemath`` Docker image.  It includes
Sage itself, and all the software packages typically included in a standard Sage installation,
though not *everything* (in particular not optional Sage SPKGs, or other system software
packages).

So in order to install additional Sage SPKGs it is possible to include a line like::

    RUN sage -i <spkg-name>
    
in the ``Dockerfile``.  Note, due to a current shortcoming in the official Docker image it is
also necessary to install the `make` system package before running ``sage -i``.  See the
next section.

Installing additional system packages
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To add additional software packages a couple more steps are involved,
albeit relatively simple.  The thing to understand about the ``sagemath/sagemath`` image is
that by default it puts you in a user called `sage`, so in order to install system packages
it is necessary, when extending the image, to first switch back to the `root` user.
Then, because the image is based on Ubuntu, the `apt-get` command can be used to install
Ubuntu packages.  The canonical way to do this in a `Dockerfile` involves updating the
APT cache, installing the packages, and then cleaning up the APT cache again all within
a single command (this is in order to keep cache files out of the image)::

    USER root
    RUN apt-get -qq update \
     && apt-get -qq install -y --no-install-recommends <packages-to-install> \
     && apt-get -qq clean
    USER sage
    
Finally, just make sure toward the end of the ``Dockerfile`` that you switch the image
user back to ``sage`` (so that when users run the container they are not running it as
``root``.
        

Authors
-------

Nicolas M. Thiéry
E. Madison Bray

The demo notebooks for GAP, Singular, and Pari were written by the
authors of the respective kernels. See the
`report on their implementation <https://github.com/OpenDreamKit/OpenDreamKit/tree/master/WP4/D4.4>`_.

Contributions most welcome!
