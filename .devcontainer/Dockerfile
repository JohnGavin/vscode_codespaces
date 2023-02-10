
# [Choice] R version: 4, 4.2, 4.1, 4.0
ARG VARIANT=4.2
# Minimal (r-ver): rocker/r-ver
# tidyverse installed: rocker/tidyverse 
# full image (binder): rocker/binder
ARG BASE_IMAGE=rocker/r-ver
# ARG BASE_IMAGE=rocker/r-ver
FROM ${BASE_IMAGE}:${VARIANT}
# FROM analythium/r2u-quarto
# FROM eddelbuettel/r2u

# [Option from ./devcontainers.json] 
# Install zsh
ARG INSTALL_ZSH="true"
# Upgrade OS packages to latest
ARG UPGRADE_PACKAGES="true"

# Install needed packages and setup non-root user. 
# Use a separate RUN statement to add your own dependencies.
ARG USERNAME=rstudio
# move rstudio home directory
ARG RSTUDIO_HOME=/workspaces/${USERNAME}
ARG USER_UID=1000
ARG USER_GID=$USER_UID
USER root
COPY library-scripts/*.sh /tmp/library-scripts/
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && /bin/bash /tmp/library-scripts/common-debian.sh "${INSTALL_ZSH}" "${USERNAME}" "${USER_UID}" "${USER_GID}" "${UPGRADE_PACKAGES}" "true" "true" \
    && usermod -a -G staff ${USERNAME} \
    && apt-get -y install \
        python3-pip \
        libgit2-dev \
        libcurl4-openssl-dev \
        libssl-dev \
        libxml2-dev \
        libxt-dev \
        libfontconfig1-dev \
        libcairo2-dev \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/library-scripts \
    && python3 -m pip --no-cache-dir install radian \
    && install2.r --error --skipinstalled --ncpus -1 \
        devtools \
        remotes \
        languageserver \
        # httpgd \
    && rm -rf /tmp/downloaded_packages

# VSCode R Debugger dependency. Install the latest release version from GitHub without using GitHub API.
# See https://github.com/microsoft/vscode-dev-containers/issues/1032
RUN export TAG=$(git ls-remote --tags --refs --sort='version:refname' https://github.com/ManuelHentschel/vscDebugger v\* | tail -n 1 | cut --delimiter='/' --fields=3) \
    && Rscript -e "remotes::install_git('https://github.com/ManuelHentschel/vscDebugger.git', ref = '"${TAG}"', dependencies = FALSE)"

# R Session watcher settings.
# See more details: https://github.com/REditorSupport/vscode-R/wiki/R-Session-watcher
RUN echo 'if (interactive() && Sys.getenv("TERM_PROGRAM") == "vscode") source(file.path(Sys.getenv("HOME"), ".vscode-R", "init.R"))' >>"${R_HOME}/etc/Rprofile.site"

# [Option] Enable vscode-jupyter support
ARG ENABLE_JUPYTER="false"
RUN if [ "${ENABLE_JUPYTER}" = "true" ]; then \
        if [ -z "$(dpkg --get-selections | grep libzmq3-dev)" ]; then \
            apt-get update \
            && export DEBIAN_FRONTEND=noninteractive \
            && apt-get -y install --no-install-recommends libzmq3-dev \
            && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*; \
        fi \
        && install2.r --error --skipinstalled --ncpus -1 IRkernel \
        && rm -rf /tmp/downloaded_packages \
        && python3 -m pip --no-cache-dir install jupyter \
        && R --vanilla -s -e 'IRkernel::installspec(user = FALSE)'; \
    fi

# [Optional] Uncomment this section to install additional OS packages.
# RUN apt-get update \
#     && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>


# [Optional] Uncomment this section to install additional R packages.
#RUN install2.r --error --skipinstalled --ncpus -1 \
#    footBayes
RUN install2.r --error --deps TRUE --skipinstalled --ncpus -1 \
    tidyverse \
    # forcats broom \
    # footBayes \
    renv remotes \
    targets tarchetypes pacman janitor import \
    tidybayes
    # fusen recipes tinytest 
    # bookdown raw citr 
RUN install2.r --error --deps TRUE --skipinstalled --ncpus -1 \
    rstan \
    brms

# Install packages (incl. remotes) for handler.R from DESCRIPTION
# RUN R -q -e 'remotes::install_deps()'
# Install VersionedPackages for handler.R from DESCRIPTION
# RUN R -q -e 'source("/usr/local/bin/install.R");install$versioned()'

RUN python3 -m pip --no-cache-dir install pandas seaborn scipy 
# tensorflow need to install underlying library first.


# rocker/binder" includes rstudio and quarto
#RUN /rocker_scripts/install_pandoc.sh
#RUN /rocker_scripts/install_quarto.sh
#RUN /rocker_scripts/install_rstudio.sh
# EXPOSE 8787

# docker compose
#    env_file: .env

# RUN sudo adduser ${USERNAME}
# is rstudio in group rstudio?
# RUN sudo chown ${USERNAME}:${USERNAME} -R ${RSTUDIO_HOME}

# reset password to rstudio
RUN sudo usermod -p `perl -e "print crypt("rstudio","Q4")"` rstudio
#RUN sudo echo "${USERNAME}:${USERNAME}" |  chpasswd 
#RUN sudo echo "rstudio:rstudio" |  chpasswd 
#RUN sudo passwd -d rstudio && passwd -l rstudio

WORKDIR ${RSTUDIO_HOME}
# WORKDIR /home/${USERNAME}
# 
# RUN sudo cp -urv "/workspaces/.config/rstudio/rstudio-prefs.json.copy" "/etc/rstudio/rstudio-prefs.json"
# copy from .devcontainer from github into /home/rstudio
#RUN sudo cp -urv "/workspaces/rstudio" "/home/rstudio"
# copy rstudio changes back into .devcontainer
#RUN sudo rsync -avu --delete "/home/rstudio/" "/workspaces/rstudio"  
# RUN sudo ln -s /home/rstudio /workspaces/rstudio

# USER root
# USER ${USERNAME}
# CMD ["/init"]
# CMD ["ipython3"]