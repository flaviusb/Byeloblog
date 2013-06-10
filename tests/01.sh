#!/bin/bash

../byeloblog.atomish "xml-regression.atomish" > xml-regression.1
diff xml-regression.1 xml-regression.2
