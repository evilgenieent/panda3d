/**
 * PANDA 3D SOFTWARE
 * Copyright (c) Carnegie Mellon University.  All rights reserved.
 *
 * All use of this software is subject to the terms of the revised BSD
 * license.  You should have received a copy of this license along
 * with this source code in a file named "LICENSE."
 *
 * @file weakPointerToBase.I
 * @author drose
 * @date 2004-09-27
 */

/**
 *
 */
template<class T>
INLINE WeakPointerToBase<T>::
WeakPointerToBase(To *ptr) {
  reassign(ptr);
}

/**
 *
 */
template<class T>
INLINE WeakPointerToBase<T>::
WeakPointerToBase(const PointerToBase<T> &copy) {
  reassign(copy);
}

/**
 *
 */
template<class T>
INLINE WeakPointerToBase<T>::
WeakPointerToBase(const WeakPointerToBase<T> &copy) {
  _void_ptr = copy._void_ptr;
  _ptr_was_deleted = copy._ptr_was_deleted;

  if (is_valid_pointer()) {
    To *ptr = (To *)_void_ptr;
    ptr->weak_ref(this);
  }
}

/**
 *
 */
template<class T>
INLINE WeakPointerToBase<T>::
~WeakPointerToBase() {
  reassign((To *)NULL);
}

/**
 * This is the main work of the PointerTo family.  When the pointer is
 * reassigned, decrement the old reference count and increment the new one.
 */
template<class T>
void WeakPointerToBase<T>::
reassign(To *ptr) {
  if (ptr != (To *)_void_ptr || _ptr_was_deleted) {
    To *old_ptr = (To *)_void_ptr;

    _void_ptr = (void *)ptr;
    if (ptr != (To *)NULL) {
      ptr->weak_ref(this);
#ifdef DO_MEMORY_USAGE
      if (MemoryUsage::get_track_memory_usage()) {
        // Make sure the MemoryUsage record knows what the TypeHandle is, if
        // we know it ourselves.
        TypeHandle type = get_type_handle(To);
        if (type == TypeHandle::none()) {
          do_init_type(To);
          type = get_type_handle(To);
        }
        if (type != TypeHandle::none()) {
          MemoryUsage::update_type(ptr, type);
        }
      }
#endif
    }

    // Now remove the old reference.
    if (old_ptr != (To *)NULL && !_ptr_was_deleted) {
      old_ptr->weak_unref(this);
    }

    _ptr_was_deleted = false;
  }
}

/**
 *
 */
template<class T>
INLINE void WeakPointerToBase<T>::
reassign(const PointerToBase<To> &copy) {
  // This double-casting is a bit of a cheat to get around the inheritance
  // issue--it's difficult to declare a template class to be a friend.
  reassign((To *)((const WeakPointerToBase<To> *)&copy)->_void_ptr);
}

/**
 *
 */
template<class T>
INLINE void WeakPointerToBase<T>::
reassign(const WeakPointerToBase<To> &copy) {
  nassertv(!copy.was_deleted());
  reassign((To *)copy._void_ptr);
}

#ifndef CPPPARSER
#ifndef WIN32_VC
/**
 *
 */
template<class T>
INLINE bool WeakPointerToBase<T>::
operator == (const To *other) const {
  return (To *)_void_ptr == other;
}

/**
 *
 */
template<class T>
INLINE bool WeakPointerToBase<T>::
operator != (const To *other) const {
  return (To *)_void_ptr != other;
}

/**
 *
 */
template<class T>
INLINE bool WeakPointerToBase<T>::
operator > (const To *other) const {
  return (To *)_void_ptr > other;
}

/**
 *
 */
template<class T>
INLINE bool WeakPointerToBase<T>::
operator <= (const To *other) const {
  return (To *)_void_ptr <= other;
}

/**
 *
 */
template<class T>
INLINE bool WeakPointerToBase<T>::
operator >= (const To *other) const {
  return (To *)_void_ptr >= other;
}
/**
 *
 */
template<class T>
INLINE bool WeakPointerToBase<T>::
operator == (To *other) const {
  return (To *)_void_ptr == other;
}

/**
 *
 */
template<class T>
INLINE bool WeakPointerToBase<T>::
operator != (To *other) const {
  return (To *)_void_ptr != other;
}

/**
 *
 */
template<class T>
INLINE bool WeakPointerToBase<T>::
operator > (To *other) const {
  return (To *)_void_ptr > other;
}

/**
 *
 */
template<class T>
INLINE bool WeakPointerToBase<T>::
operator <= (To *other) const {
  return (To *)_void_ptr <= other;
}

/**
 *
 */
template<class T>
INLINE bool WeakPointerToBase<T>::
operator >= (To *other) const {
  return (To *)_void_ptr >= other;
}

/**
 *
 */
template<class T>
INLINE bool WeakPointerToBase<T>::
operator == (const WeakPointerToBase<To> &other) const {
  return (To *)_void_ptr == (To *)other._void_ptr;
}

/**
 *
 */
template<class T>
INLINE bool WeakPointerToBase<T>::
operator != (const WeakPointerToBase<To> &other) const {
  return (To *)_void_ptr != (To *)other._void_ptr;
}

/**
 *
 */
template<class T>
INLINE bool WeakPointerToBase<T>::
operator > (const WeakPointerToBase<To> &other) const {
  return (To *)_void_ptr > (To *)other._void_ptr;
}

/**
 *
 */
template<class T>
INLINE bool WeakPointerToBase<T>::
operator <= (const WeakPointerToBase<To> &other) const {
  return (To *)_void_ptr <= (To *)other._void_ptr;
}

/**
 *
 */
template<class T>
INLINE bool WeakPointerToBase<T>::
operator >= (const WeakPointerToBase<To> &other) const {
  return (To *)_void_ptr >= (To *)other._void_ptr;
}

/**
 *
 */
template<class T>
INLINE bool WeakPointerToBase<T>::
operator == (const PointerToBase<To> &other) const {
  return (To *)_void_ptr == (To *)((WeakPointerToBase<To> *)&other)->_void_ptr;
}

/**
 *
 */
template<class T>
INLINE bool WeakPointerToBase<T>::
operator != (const PointerToBase<To> &other) const {
  return (To *)_void_ptr != (To *)((WeakPointerToBase<To> *)&other)->_void_ptr;
}

/**
 *
 */
template<class T>
INLINE bool WeakPointerToBase<T>::
operator > (const PointerToBase<To> &other) const {
  return (To *)_void_ptr > (To *)((WeakPointerToBase<To> *)&other)->_void_ptr;
}

/**
 *
 */
template<class T>
INLINE bool WeakPointerToBase<T>::
operator <= (const PointerToBase<To> &other) const {
  return (To *)_void_ptr <= (To *)((WeakPointerToBase<To> *)&other)->_void_ptr;
}

/**
 *
 */
template<class T>
INLINE bool WeakPointerToBase<T>::
operator >= (const PointerToBase<To> &other) const {
  return (To *)_void_ptr >= (To *)((WeakPointerToBase<To> *)&other)->_void_ptr;
}
#endif  // WIN32_VC

/**
 *
 */
template<class T>
INLINE bool WeakPointerToBase<T>::
operator < (const To *other) const {
  return (To *)_void_ptr < other;
}

/**
 *
 */
template<class T>
INLINE bool WeakPointerToBase<T>::
operator < (const WeakPointerToBase<To> &other) const {
  return (To *)_void_ptr < (To *)other._void_ptr;
}

/**
 *
 */
template<class T>
INLINE bool WeakPointerToBase<T>::
operator < (const PointerToBase<To> &other) const {
  return (To *)_void_ptr < (To *)((WeakPointerToBase<To> *)&other)->_void_ptr;
}

#endif  // CPPPARSER



/**
 * A convenient way to set the PointerTo object to NULL. (Assignment to a NULL
 * pointer also works, of course.)
 */
template<class T>
INLINE void WeakPointerToBase<T>::
clear() {
  reassign((To *)NULL);
}

/**
 * Informs the WeakPointerTo object that its pointer is no longer deleted.
 * This may be used after a WeakPointerTo has deleted a deleted pointer, and
 * then a new pointer has been reallocated.  It's equivalent to simply
 * reassigning the pointer to its new (i.e.  original) value, but has the
 * advantage that it is const, so can be used for WeakPointers used as keys in
 * STL maps and sets.
 */
template<class T>
INLINE void WeakPointerToBase<T>::
refresh() const {
  ((WeakPointerToBase<T> *)this)->reassign((To *)_void_ptr);
}

/**
 * A handy function to output PointerTo's as a hex pointer followed by a
 * reference count.
 */
template<class T>
INLINE void WeakPointerToBase<T>::
output(ostream &out) const {
  out << _void_ptr;
  if (was_deleted()) {
    out << ":deleted";
  } else if (_void_ptr != (void *)NULL) {
    out << ":" << ((To *)_void_ptr)->get_ref_count();
  }
}
