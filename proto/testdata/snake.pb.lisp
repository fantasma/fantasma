; Work in progress.

(literals (as (literal_uint32 0)))
(literals (as (literal_uint32 1)))
(types (as (builtin BUILTIN_TYPE_VOID)))
(types (as (builtin BUILTIN_TYPE_UINT32)))
(types (as (builtin BUILTIN_TYPE_BOOLEAN)))

(sprites
  (name "Tile")
  (links
    (exposes (name "snake_segment")
             (type_id 1))
    (exposes (name "has_food")
             (type_id 2))
    (remotes (name "direction")
             (type_id 3))
    (remotes (name "stagger")
             (type_id 2)))
  (methods
    (statements
      (name "snake_segment")
      (type_id 1)
      (op (declare_frame_variable))
      (args (op (value_from_link_variable (link_id 0) (id 0)))))
    (statements
      ; check if i am a snake
      (op (if_statement))
      (args (op (builtin BUILTIN_GT))
            (args (op (value_from_link_variable (link_id 0) (id 0))))
            (args (op (value_from_literal_id 0)))))
    (statements
      ; check if i should stagger by 1
      (op (if_statement))
      (args (op (builtin BUILTIN_NOT))
            (args (op (value_from_link (link_id 0) (remote true) (id 1))))))
    (statements
      ; if i should stagger, then do it
      (op (assign_frame_variable))
      (args (op (reference_from_frame_variable_name "snake_segment")))
      (args (op (builtin BUILTIN_SUB))
            (args (op (value_from_frame_variable_name "snake_segment")))
            (args (op (value_from_literal_id 1)))))
    )
  )
