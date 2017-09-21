FROM continuumio/anaconda3
MAINTAINER Chad <chad.d.lagore@gmail.com>

# Set up nodejs for later extension installations
RUN conda install -c anaconda nodejs

# Set up jupyerlab.
RUN conda install -c conda-forge jupyterlab

# Add additional deps.
ADD requirements.txt /env/requirements.txt
RUN pip install -r /env/requirements.txt

# Get our configs, profiles and application files in
ADD root/ /root/
ADD app/ /app/

# Clean up conda cache and tarballs
RUN conda clean -ay

WORKDIR /app/nb/

EXPOSE 8080

ENTRYPOINT jupyter lab --ip="*" --allow-root --no-browser --port=8080
