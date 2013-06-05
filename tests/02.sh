#!/bin/bash

# We skip these unwritten tests

exit 0

../byeloblog.atomish "`pwd`/genx-regression.atomish" > genx-regression.1
diff genx-regression.1 genx-regression.2
