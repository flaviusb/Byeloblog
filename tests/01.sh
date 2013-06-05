#!/bin/bash

../byeloblog.atomish "tests/xml-regression.atomish" > xml-regression.1
diff xml-regression.1 xml-regression.2
