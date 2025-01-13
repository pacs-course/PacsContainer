# syntax=docker/dockerfile:1
# Use the official ubuntu image for amd64
FROM --platform=linux/amd64 ubuntu:24.04

# If you do not want to reganarate everithing you have to change this number
# It does not work, unfortunately. So if you change the value all is
# a real pity.
ARG CACHEBURST=2
# Set the user root
USER root
# prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install the required packages
RUN apt-get update
RUN apt-get install -y \
    build-essential bash-completion\
    python3 \
    python3-pip \
    python3-venv \
    tzdata apt-utils \
    software-properties-common \
    g++ gcc  gfortran \
    clang clang-format clang-tidy clang-tools \
    libtbb12 libtbb-dev cmake \
    openmpi-bin openmpi-common libopenmpi-dev \
    wget bzip2 ca-certificates git \
    net-tools libeigen3-dev -y libboost-all-dev \
    libsuitesparse-dev gnuplot libgnuplot-iostream-dev \
    libhdf5-serial-dev libhdf5-mpich-dev \
    libblas-dev libopenblas-dev \
    liblapack-dev liblapacke-dev \
    sudo vim gedit

#clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

#Create a new user
ENV USER_NAME pacs
ENV USER_HOME /home/${USER_NAME}
ENV USER_GROUP numer
ENV USER_ID 1001
ENV USER_GID 1001
RUN groupadd -g ${USER_GID} ${USER_GROUP} && \
    useradd -m -u ${USER_ID} -g ${USER_GROUP} -s /bin/bash ${USER_NAME}
#RUN adduser --disabled-password '' ${USER_NAME}
#add user to sudo grup
RUN usermod -aG sudo ${USER_NAME}
# allow passwordless sudo for the user 
RUN echo "${USER_NAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
# chenge the owner of the home directory
RUN chown -R ${USER_NAME}:${USER_GROUP} ${USER_HOME}
# Set the user
USER ${USER_NAME}
WORKDIR ${USER_HOME}
# generate a ssh key pair In case you want to change the way you access the pacs repository
RUN  mkdir -p ${USER_HOME}/.ssh && ssh-keygen -t rsa -f ${USER_HOME}/.ssh/id_rsa -N ""
RUN chmod 700 ${USER_HOME}/.ssh && chmod 600 ${USER_HOME}/.ssh/id_rsa
# Add the public key to known_hosts to avoid SSH prompt
RUN ssh-keyscan github.com >> ${USER_HOME}/.ssh/known_hosts
# Add the SSH key to the ssh-agent
RUN eval "$(ssh-agent -s)" && ssh-add ${USER_HOME}/.ssh/id_rsa

# download pacs-examples using https. cleanup previous installations
RUN echo $CASHBURST at `date` >${USER_HOME}/build_date.txt && cd ${USER_HOME} && rm -r -f ./pacs-examples && git clone https://github.com/pacs-course/pacs-examples.git ./pacs-examples
# This cannot work in the container because the container ssh key is not added to the github account
# If you add the ssh key to the github account you can change the protocol to ssh with the following command
# git remote git@github.com:pacs-course/pacs-examples.git origin
# This command is executed any time, ignoring cache
#RUN echo $CASHBURST at `date` >${USER_HOME}/build_date.txt && git clone --recursive git@github.com:pacs-course/pacs-examples.git
# I need not to chenge protocol also to submodules and compile them
RUN echo $CASHBURST at `date` >${USER_HOME}/build_date.txt && cd ${USER_HOME}/pacs-examples && ./change_submodules_url_https.sh
RUN echo $CASHBURST at `date` >${USER_HOME}/build_date.txt && cd ${USER_HOME}/pacs-examples && ./install-git-submodules.sh

# Set the pacs-root environment variable
ENV PACS_ROOT=${USER_HOME}/pacs-examples/Examples

# Set a few variable for consistency with the module system 
ENV mkSuitesparseInc=/usr/include/suitesparse/
ENV mkOpenblasInc=/usr/include/x86_64-linux-gnu/openblas-pthread
ENV mkTbbInc=/usr/include
ENV mkHdf5Lib=/usr/lib/x86_64-linux-gnu/hdf5/serial/
ENV mkHdf5Inc=/usr/include/hdf5/serial/
ENV mkEigenInc=/usr/include/eigen3
ENV mkTbbLib=/usr/lib/x86_64-linux-gnu/
ENV mkEigenHome=/usr/include/eigen3
ENV mkBoostLib=/usr/lib/x86_64-linux-gnu/
ENV mkPybind11Prefix=${PACS_ROOT}/share/cmake/
ENV mkCxxCompiler=/usr/bin/g++
ENV mkOpenblasLib=/usr/lib/x86_64-linux-gnu/openblas-pthread/
ENV mkSuitesparseLib=/usr/lib/x86_64-linux-gnu
ENV mkBoostInc=/usr/include

# Set the entrypoint
ENTRYPOINT ["/bin/bash"]
# Set the default command
CMD ["-l"]

# Set the main Makefile
RUN echo $CASHBURST at `date` >${USER_HOME}/build_date.txt && cd ${PACS_ROOT} && cp Makefile.container Makefile.inc
# Build the required libraries and install required header files
RUN echo $CASHBURST at `date` >${USER_HOME}/build_date.txt && cd ${PACS_ROOT}/src/Utilities && make && make install
RUN echo $CASHBURST at `date` >${USER_HOME}/build_date.txt && cd ${PACS_ROOT}/src/LinearAlgebraUtil && make && make install

# Install the laboratory sessions
RUN echo $CASHBURST at `date` >${USER_HOME}/build_date.txt && cd ${USER_HOME} && rm -r -f ./pacs-Labs && git clone https://github.com/pacs-course/pacs-Labs.git ./pacs-Labs

# Build the image
# docker build -t pacs-examples -f Dockerfile .
# push the image
# docker tag pacs-examples <username>/<imagename>:<tag> (tag is usualy latest
# docker login <username>
# docker push <username>/<imagename>:<tag>
# Run the container
# docker run -it --rm pacs-examples
# docker run -it --rm -v ./shared_files:/home/pacs/pacs-examples/shared_files pacs-examples
