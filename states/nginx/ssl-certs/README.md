Put your certificates here
==========================

# Generate key

    openssl genrsa -des3 -out fqdn.key 1024

# Generate Certificate Signing Request (CSR)

    openssl req -new -key fqdn.key -out fqdn.csr

Enter fqdn as Common Name (CN), i.e. example.com...

# Remove password

    cp fqdn.key fqdn.key.orig
    openssl rsa -in fqdn.key.orig -out fqdn.key

# Generate SSL certificate

    openssl x509 -req -days 365 -in fqdn.csr -signkey fqdn.key -out fqdn.crt

That's it.
