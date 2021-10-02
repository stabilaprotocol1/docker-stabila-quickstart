Utilities

The following tools are useful during debugging and development

build.sh builds the local image stabilaquickstart.

run.sh runs stabilaquickstart generating a stabila container on ports 8090, 8091 and 8092.

run-persistent.sh runs stabilaquickstart using local folders for data persistence, generating a stabila container.

bash.sh connects to the stabila container opening a bash prompt.

build-and-run.sh is a shortcut for build.sh && run.sh.

accounts-list.sh shows the accounts available in the stabila container.

tag.sh tags a new stabilaquickstart image in preparation of a push to the Docker Hub.

verify.sh verifies the full node, solidity node and eventServer are listening.

run-previous-latest.sh runs latest released version of stabilatools/quickstart on ports 88090, 88091, 88092 and 89090 (to avoid conflicts with the work-in-progress stabilaquickstart which runs, typically, on ports 8090, 8091, 8092 and 9090).