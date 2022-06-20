
## Tool Versions
CONTROLLER_TOOLS_VERSION ?= v0.8.0

.PHONY: manifests
manifests: controller-gen ## Generate WebhookConfiguration, ClusterRole and CustomResourceDefinition objects.
	$(CONTROLLER_GEN) rbac:roleName=manager-role crd webhook paths="./..." output:crd:artifacts:config=config/crd/bases

.PHONY: generate
generate: controller-gen deepequal-gen ## Generate code containing DeepCopy, DeepEqual, DeepCopyInto, and DeepCopyObject method implementations.
	$(CONTROLLER_GEN) object:headerFile="hack/boilerplate.go.txt" paths="./..."
	$(DEEPEQUAL_GEN) -v 1 -o ${PWD} -O zz_generated.deepequal -i ./api/v1 -h ./hack/boilerplate.go.txt 

.PHONY: fmt
fmt: ## Run go fmt against code.
	go fmt ./...

.PHONY: vet
vet: ## Run go vet against code.
	go vet ./...


## Location to install dependencies to
LOCALBIN ?= $(shell pwd)/bin
$(LOCALBIN):
	mkdir -p $(LOCALBIN)

## Tool Binaries
CONTROLLER_GEN ?= $(LOCALBIN)/controller-gen
DEEPEQUAL_GEN ?= $(LOCALBIN)/deepequal-gen

.PHONY: controller-gen
controller-gen: $(CONTROLLER_GEN) ## Download controller-gen locally if necessary.
$(CONTROLLER_GEN): $(LOCALBIN)
	GOBIN=$(LOCALBIN) go install sigs.k8s.io/controller-tools/cmd/controller-gen@$(CONTROLLER_TOOLS_VERSION)

.PHONY: deepequal-gen
deepequal-gen: $(DEEPEQUAL_GEN) ## Download deepequal-gen locally if necessary.
$(DEEPEQUAL_GEN): $(LOCALBIN)
	GOBIN=$(LOCALBIN) go install github.com/wind-river/deepequal-gen@latest