import os
import psycopg2
import urlparse


def parse_database_url(url):
    """
    Parses a database url and returns a dictionary of values:
        {
            'HOST': <YOUR_HOST>,
            'PORT': <YOUR_PORT>,
            'USERNAME': <YOUR_USERNAME>,
            'PASSWORD': <YOUR_PASSWORD>,
            'DATABASE': <YOUR_DATABASE_NAME>,
            'FULLPATH': '/'<YOUR_DATABASE_NAME>
        }
    """
    if not url:
        return {}

    # Grab the scheme first, and tell urlparse that it uses
    # netlocs and query params so that it'll parse the URL
    # fully.
    scheme = url.split(':')[0]
    urlparse.uses_netloc.append(scheme)
    urlparse.uses_params.append(scheme)

    # Parse the URL
    parsed = urlparse.urlparse(url)

    # Build the output
    output = dict(
        HOST=parsed.hostname,
        PORT=str(parsed.port),
        USERNAME=parsed.username,
        PASSWORD=parsed.password,
        FULLPATH=parsed.path,
        DATABASE=parsed.path.lstrip('/')
    )

    # Do the query
    if parsed.query:
        output.update(
            (k.upper(), v[0] or '')
            for (k, v) in urlparse.parse_qs(
                parsed.query,
                True
            ).iteritems()
        )

    # Convert the dict to eliminate 'None' values
    sane_output = {
        k: (v or '')
        for k, v in output.iteritems()
    }

    return sane_output


def get_connection(env_var):
    """
    Obtain a psycopg2 connection from a string that calls the env variable
    that holds a database url
    """
    import os
    url = os.getenv(env_var, '')
    assert url, 'Credentials not found'
    db_config = parse_database_url(url)
    connection = psycopg2.connect(
        host=db_config['HOST'],
        port=db_config['PORT'],
        database=db_config['DATABASE'],
        user=db_config['USERNAME'],
        password=db_config['PASSWORD'])
    connection.set_client_encoding('utf-8')
    return connection
