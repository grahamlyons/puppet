.PHONY: deploy

SERVER=
PUPPET_ROOT=/var/puppet
UPDATE_COMMAND=sudo puppet apply --modulepath=${PUPPET_ROOT}/modules ${PUPPET_ROOT}/manifests/site.pp

deploy: update
	ssh ${SERVER} "${UPDATE_COMMAND}"

update:
	ssh ${SERVER} "cd ${PUPPET_ROOT} && sudo git pull"

ifndef SERVER
	$(error SERVER not definded)
endif
