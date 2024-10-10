Oh no... It looks like a missile was launched, we need to act quickly!

And whatever you do, do not execute this code snippet. I beg you, please, do not do it!!!

```
bash /usr/local/bin/do_not_run_this_script
```{{exec}}

To abort the launch, run this script:
```
bash /usr/local/bin/abort
```{{exec}}

Oh no, it looks like this ansible playbook version does not have a functioning version of the abort function. You now need to load the backup playbook, quickly!

```
ansible-playbook -i inventory.ini recovery.yml
```{{exec}}

Now try to run the abort script again!
```
bash /usr/local/bin/abort
```{{exec}}