# NodeLink Ansible

Ansible repository for the NodeLink infrastructure

## Requirements

- Ansible core >= 2.16

```bash
python -m venv .venv && source .venv/bin/activate
pip install ansible
ansible-galaxy collection install -r requirements.yml
```

## Usage

Check syntax:

```bash
ansible-playbook playbook.yml --syntax-check
```

Test connectivity:

```bash
ansible Linux-Nodelink -m ping
```

Restrict to a host or group 

```bash
ansible-playbook site.yml --limit <host|group>
```
