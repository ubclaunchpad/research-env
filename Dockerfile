FROM continuumio/anaconda3
MAINTAINER Chad <chad.d.lagore@gmail.com>

# Set up nodejs for later extension installations
RUN conda install -c anaconda nodejs

# Set up jupyerlab.
RUN conda install -c conda-forge jupyterlab && \
    jupyter labextension disable @jupyterlab/terminal-extension

# Add additional deps.
ADD requirements.txt /env/requirements.txt
RUN conda install --file=/env/requirements.txt

# Get our configs and profiles in
ADD root/ /root/

# Clean up conda cache and tarballs
RUN conda clean -ay

WORKDIR /app

EXPOSE 8080

ENTRYPOINT jupyter lab --ip="*" --allow-root --no-browser --port=8080
