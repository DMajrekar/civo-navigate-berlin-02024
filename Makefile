
# setup will run a targetted apply of terraform resources in lon and nyc to make the demo quicker
setup:
	cd terraform && terraform init
	cd terraform && terraform apply -target civo_network.network -auto-approve
	cd terraform && terraform apply -target civo_firewall.cluster-firewall -auto-approve
	cd terraform && terraform apply -target civo_firewall.database-firewall -auto-approve

destroy:
	cd terraform && terraform destroy -auto-approve

step1:
	clear
	@echo
	cat terraform/provider.tf
	@echo
	@read -n 1 -s -p "Create the cluster"

step2:
	clear
	cd terraform && terraform apply -target local_file.cluster-config -auto-approve
	@echo
	@read -n 1 -s -p "Get the kubeconfig for the new cluster"

step3:
	clear
	cat terraform/kubeconfig
	@sleep 10
	@echo
	@read -n 1 -s -p "Get the nodes in the cluster"

step4:
	clear
	KUBECONFIG=terraform/kubeconfig kubectl get nodes 
	@echo
	@read -n 1 -s -p "Create the database"

step5:
	clear
	@echo
	cat terraform/civo-database.tf
	@echo
	@read -n 1 -s -p ""

step6:
	clear
	@echo "Create the database"
	@echo
	cd terraform && terraform apply -target civo_database.database -auto-approve
	@echo
	@read -n 1 -s -p ""

step7:
	clear
	@echo "Create the remaining resources for the rest of the demo"
	@echo
	cd terraform && terraform apply -auto-approve
	@echo
	@read -n 1 -s -p "Get the secret from the cluster"

step8:
	clear
	KUBECONFIG=terraform/kubeconfig kubectl get secret -n default database-access -o json | jq '.data'
	@echo
	@read -n 1 -s -p ""

demo: step1 step2 step3 step4 step5 step6 step7 step8 

.PHONY: demo destroy steup step1 step2 step3 step4 step5 step6 step7 step8 

