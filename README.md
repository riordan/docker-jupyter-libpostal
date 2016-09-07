Docker-jupyter-libpostal
=========================
Extends Jupyter's [Docker-Stacks](https://github.com/jupyter/docker-stacks) for the [scipy-notebook](https://github.com/jupyter/docker-stacks/tree/master/scipy-notebook) to add the [Libpostal](https://github.com/openvenues/libpostal) library and its python bindings, [pypostal](https://github.com/openvenues/pypostal).

# Usage
Extends the configuration of the scipy-notebook
## Basic Use

The following command starts a container with the Notebook server listening for HTTP connections on port 8888 without authentication configured.

```
docker run -d -p 8888:8888 jupyter/scipy-notebook
```

## pypostal Usage
```python
from postal.expand import expand_address
expand_address('Quatre vingt douze Ave des Champs-Élysées')

from postal.parser import parse_address
parse_address('The Book Club 100-106 Leonard St, Shoreditch, London, Greater London, EC2A 4RH, United Kingdom')
```
For additional details, please see the [pypostal](https://github.com/openvenues/pypostal) project.


## Notebook Options

The Docker container executes a [`start-notebook.sh` script](../base-notebook/start-notebook.sh) script by default. The `start-notebook.sh` script handles the `NB_UID` and `GRANT_SUDO` features documented in the next section, and then executes the `jupyter notebook`.

You can pass [Jupyter command line options](http://jupyter.readthedocs.org/en/latest/config.html#command-line-arguments) through the `start-notebook.sh` script when launching the container. For example, to secure the Notebook server with a password hashed using `IPython.lib.passwd()`, run the following:

```
docker run -d -p 8888:8888 jupyter/scipy-notebook start-notebook.sh --NotebookApp.password='sha1:74ba40f8a388:c913541b7ee99d15d5ed31d4226bf7838f83a50e'
```

For example, to set the base URL of the notebook server, run the following:

```
docker run -d -p 8888:8888 jupyter/scipy-notebook start-notebook.sh --NotebookApp.base_url=/some/path
```

You can sidestep the `start-notebook.sh` script and run your own commands in the container. See the *Alternative Commands* section later in this document for more information.


## Docker Options

You may customize the execution of the Docker container and the Notebook server it contains with the following optional arguments.

* `-e PASSWORD="YOURPASS"` - Configures Jupyter Notebook to require the given plain-text password. Should be combined with `USE_HTTPS` on untrusted networks. **Note** that this option is not as secure as passing a pre-hashed password on the command line as shown above.
* `-e USE_HTTPS=yes` - Configures Jupyter Notebook to accept encrypted HTTPS connections. If a `pem` file containing a SSL certificate and key is not provided (see below), the container will generate a self-signed certificate for you.
* `-e NB_UID=1000` - Specify the uid of the `jovyan` user. Useful to mount host volumes with specific file ownership. For this option to take effect, you must run the container with `--user root`. (The `start-notebook.sh` script will `su jovyan` after adjusting the user id.)
* `-e GRANT_SUDO=yes` - Gives the `jovyan` user passwordless `sudo` capability. Useful for installing OS packages. For this option to take effect, you must run the container with `--user root`. (The `start-notebook.sh` script will `su jovyan` after adding `jovyan` to sudoers.) **You should only enable `sudo` if you trust the user or if the container is running on an isolated host.**
* `-v /some/host/folder/for/work:/home/jovyan/work` - Host mounts the default working directory on the host to preserve work even when the container is destroyed and recreated (e.g., during an upgrade).
* `-v /some/host/folder/for/server.pem:/home/jovyan/.local/share/jupyter/notebook.pem` - Mounts a SSL certificate plus key for `USE_HTTPS`. Useful if you have a real certificate for the domain under which you are running the Notebook server.

For additional documentation, please see the [scipy-notebook](https://github.com/jupyter/docker-stacks/tree/master/scipy-notebook) documentation.
