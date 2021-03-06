########################################################################################################################
#!!
#! @description: Creates multiple SAP users.
#!               Couple of examples on formating
#!               {:03d}          user001, user002, user003, ... user030
#!               user{}          user1, user2, user3, ... user30
#!               FMI on format, see https://pyformat.info/
#!
#! @input username_format: user{:03d} will generate users like user001, user002, user003 ... user030
#! @input first_name_format: rpa{} will generate names like rpa1, rpa2, rpa3 ... rpa30
#! @input set_admin: Attach the created users the SAP_ALL profile
#!!#
########################################################################################################################
namespace: SAP.user.bulk
flow:
  name: create_users
  inputs:
    - start_index: '1'
    - last_index: '30'
    - username_format: 'user{:03d}'
    - first_name_format: 'rpa{}'
    - last_name_format: bootcamp
    - email_format: 'rpa.bootcamp{}@microfocus.com'
    - password_format: cloud1
    - set_admin: 'true'
  workflow:
    - create_user:
        parallel_loop:
          for: 'index in range(int(start_index), int(last_index)+1)'
          do:
            SAP.user.create_user:
              - username: '${username_format.format(index)}'
              - first_name: '${first_name_format.format(index)}'
              - last_name: '${last_name_format.format(index)}'
              - email: '${email_format.format(index)}'
              - password: '${password_format.format(index)}'
              - set_admin: '${set_admin}'
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      create_user:
        x: 117
        'y': 90
        navigate:
          d35ab8f0-a8fb-2a9e-4c88-ae525fb85604:
            targetId: a7c42932-03be-9724-8833-48231aff8314
            port: SUCCESS
    results:
      SUCCESS:
        a7c42932-03be-9724-8833-48231aff8314:
          x: 265
          'y': 89
