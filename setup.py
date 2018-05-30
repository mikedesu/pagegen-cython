from distutils.core import setup
from Cython.Build import cythonize

setup(
    name='pagegen',
    ext_modules=cythonize('pagegen.pyx')
)

