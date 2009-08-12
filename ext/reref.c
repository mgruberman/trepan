#include "ruby.h"

extern VALUE rb_cObject;
extern VALUE rb_cFixnum;

/*
 * call-seq:
 *    obj.__value__   => (VALUE*)obj
 *
 * Returns an object's C (VALUE) for use in correlating Ruby objects
 * to C objects.
 */
VALUE
rb___value__(ref)
    VALUE ref;
{
    return 1 | (ref << 1);
}

/*
 * call-seq:
 *    fixnum.__object__   => obj
 *
 * Dereferences a fixnum to produce Ruby object.
 */
VALUE
rb___object__(ref)
    VALUE ref;
{
    return (VALUE)NUM2INT(ref);
}

void
Init_reref(void)
{
    rb_define_method(rb_cObject,"__value__",rb___value__, 0);
    rb_define_method(rb_cFixnum,"__object__",rb___object__,0);
}

/*
 * Local variables:
 * mode: c
 * c-indentation-style: bsd
 * c-basic-offset: 4
 * indent-tabs-mode: nil
 * tab-width: 8
 * End:
 *
 * ex: set ts=8 sts=4 sw=4 noet:
 */
