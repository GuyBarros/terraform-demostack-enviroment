all: deploy
.PHONY: all doormat_creds doormat_aws deploy destroy console
WORKSPACE = Guy-AWS-Demostack
WORKSPACE_ENV = Guy-AWS-Demostack
WORKSPACE_DNS = Guy-DNS-Zone
WORKSPACE_GUY = Guy-Demostack-V2
check_creds = $(shell doormat --smoke-test 1>&2 2>/dev/null; echo $$?)
doormat_creds:
ifneq ($(check_creds), 0)
	doormat --refresh
endif
guy: doormat_creds
	doormat aws --account se_demos_dev \
		--tf-push --tf-organization GuyBarros \
		--tf-workspace $(WORKSPACE_GUY)
guyguy: doormat_creds
	doormat aws --account se_demos_dev \
		--tf-push --tf-organization GuyBarros \
		--tf-workspace $(WORKSPACE)
guydns: doormat_creds
	doormat aws --account se_demos_dev \
		--tf-push --tf-organization GuyBarros \
		--tf-workspace $(WORKSPACE_DNS)			
aws: doormat_creds
	doormat aws --account se_demos_dev \
		--tf-push --tf-organization emea-se-playground-2019 \
		--tf-workspace $(WORKSPACE)
dns: doormat_creds
	doormat aws --account se_demos_dev \
		--tf-push --tf-organization emea-se-playground-2019 \
		--tf-workspace $(WORKSPACE_DNS)
env: doormat_creds
	doormat aws --account se_demos_dev \
		--tf-push --tf-organization GuyBarros \
		--tf-workspace $(WORKSPACE_ENV)				
deploy: doormat_aws
	terraform init -upgrade && terraform apply -auto-approve
destroy: doormat_aws
	terraform init -upgrade && terraform destroy -auto-approve
console: doormat_creds
	doormat aws --account se_demos_dev --console