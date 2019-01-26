

# Windows

    httpd.exe -k install -n "IBM HTTP Server V9.0"
    # Fixed name to address error:
    # The system cannot find the file specified.  : AH00436: No installed service named "IBM HTTP Server V9.0".
    apache.exe -k start