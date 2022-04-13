sshd:
	docker buildx build -t sshd:latest --build-arg USER=$(shell id -nu) --build-arg PUBKEY="$(shell cat ~/.ssh/id_ed25519.pub)" $@

git-mirror: sshd
	docker buildx build -t git-mirror:latest --build-arg USER=git --build-arg PUBKEY="$(shell cat ~/.ssh/id_ed25519.pub)" $@

.PHONY: sshd git-mirror
