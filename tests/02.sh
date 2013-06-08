#!/bin/bash

# We skip these unwritten tests

../byeloblog.atomish "tests/genx-regression.atomish" > genx-regression.1
diff genx-regression.1 genx-regression.2
