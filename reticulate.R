getwd()
Sys.getenv('RETICULATE_PYTHON')
library(reticulate, quietly = TRUE)
py_available()
py_discover_config()
py_config()
pd$show_versions()
# https://rstudio.github.io/reticulate/articles/versions.html
# py_dir <- "/Users/jbg/Documents/GitHub/shiny-python/.venv_shiny/bin/python"
# use_python(py_dir)
# use_virtualenv(py_dir)
# use_python("/Users/jbg/Library/r-miniconda/envs/r-reticulate/bin/python")

os <- import("os")
os$listdir(".")
pd <- import("pandas")
pd$__version__
#scipy <- import("scipy")
#scipy$amin(c(1,3,5,7))

repl_python()
# import pandas


