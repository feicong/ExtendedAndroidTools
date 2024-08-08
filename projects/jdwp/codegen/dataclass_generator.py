# Copyright (c) Meta Platforms, Inc. and affiliates.

import enum
from textwrap import dedent
from projects.jdwp.codegen.types import python_type_for
import typing

from projects.jdwp.defs.schema import (
    Array,
    ArrayLength,
    Command,
    CommandSet,
    Field,
    Struct,
    TaggedUnion,
    UnionTag,
)


StructLink = typing.Tuple[Struct, Field, Struct]


class StructGenerator:
    def __init__(self, root: Struct, name: str):
        self.__root = root
        self.__struct_to_name = compute_struct_names(root, name)

    def __get_python_type_for(self, struct: Struct, field: Field) -> str:
        type = field.type
        match type:
            case Struct():
                return self.__struct_to_name[type]
            case Array():
                array_type = typing.cast(Array, type)
                return f"typing.List[{self.__struct_to_name[array_type.element_type]}]"
            case TaggedUnion():
