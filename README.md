Kubernetes Add-ons deployment
-----------------------------

This is a set of convenience scripts to deploy various add-ons on a Kubernetes endpoint.

You will need a kubernetes endpoint available and `kubectl` on your local system.

Then run the `deploy-addons.sh` script

    $ ./deploy-addons.sh

By default it will deploy the DNS addon, the Dashboard and Deployment Manager.
If you want to deploy only one of them edit `deploy-addons.sh` and set the environment variable accordingly.

Deployment Manager
~~~~~~~~~~~~~~~~~~

[Deployment Manager](https://github.com/kubernetes/deployment-manager) (DM) is deployed via:

    $ curl -s https://raw.githubusercontent.com/kubernetes/deployment-manager/master/get-install.sh | sh

DNS and Dashboard
~~~~~~~~~~~~~~~~~

Both of these add-ons are deployed based on the script in the `mesos/docker` [directory](https://github.com/kubernetes/kubernetes/tree/master/cluster/mesos/docker).

The DNS add-ons uses `intemp.sh` from the thirdparty [repo](https://github.com/kubernetes/kubernetes/tree/master/third_party/intemp).
