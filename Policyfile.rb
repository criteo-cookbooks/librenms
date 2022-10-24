name 'librenms'

run_list ['librenms']

default_source :community
cookbook 'librenms', path: '.'
