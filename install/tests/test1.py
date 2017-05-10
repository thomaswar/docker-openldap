import os
from ldap3 import Server, Connection, ALL, LDIF, MODIFY_REPLACE

# variables
rootpw = os.environ['ROOTPW'] if 'ROOTPW' in os.environ else 'changeit'
port = os.environ['SLAPDPORT'] if 'SLAPDPORT' in os.environ else '8389'
host = 'localhost:' + port
rootdn = 'dc=at'
admindn = 'cn=admin,dc=at'
testpw = 'test'

print('connection establishment')
s = Server(host, get_info=ALL)
c = Connection(s, admindn, rootpw, auto_bind=True, raise_exceptions=True, client_strategy=LDIF)


print('dump_testuser search')
c.search('dc=at', '(objectclass=*)')
import pdb; pdb.set_trace()
print('; '.join(c.entries))

print('change password')
c.modify('uid=test.user2_adam', {'userPassword': [(MODIFY_REPLACE, ['newpass'])]})
