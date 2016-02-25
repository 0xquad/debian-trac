#!/bin/sh

# Variable must be defined.
[ -n "$TRAC_ROOT" ] || exit 1
# Skip initialization if a database is already present.
[ -f "$TRAC_ROOT/db/trac.db" ] || {
    (echo; echo) | trac-admin ${TRAC_ROOT} initenv >/dev/null
    mkdir -p ${TRAC_ROOT}/files
    trac-admin ${TRAC_ROOT} component remove component1
    trac-admin ${TRAC_ROOT} component remove component2
    trac-admin ${TRAC_ROOT} version remove 1.0
    trac-admin ${TRAC_ROOT} version remove 2.0
    trac-admin ${TRAC_ROOT} milestone remove milestone1
    trac-admin ${TRAC_ROOT} milestone remove milestone2
    trac-admin ${TRAC_ROOT} milestone remove milestone3
    trac-admin ${TRAC_ROOT} milestone remove milestone4
    trac-admin ${TRAC_ROOT} permission add anonymous TRAC_ADMIN
}

exec tracd -s ${TRAC_ROOT}
