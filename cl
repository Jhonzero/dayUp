

一、










二、


【注】
Big-Endian 顺序是指按高位字节在地址最低位，最低字节在地址最高位来存储数据 
Little-Endian顺序 


【内部表示名称】
1）全限定名     ： 指的是 在整个 JVM 中的绝对名称
	-- 在Class 文件结构中出现的 类或 接口的名称，都通过 全限定名形式来表示。  
	-- 也称作“二进制名称”，该名称使用 CONSTANT_Utf8_info 结构来表示
	-- 
2）非全限定名：指的是 当前环境（如当前类）中的相对名称
	-- 方法名，字段名和局部变量名都被使用非全限定名 进行存储。
	-- 非全限定名 中不能包含ASCII 字符 "."、";"、"["、"/"。 也不能包含他们的 unitcode 表示形式


【】
1、每个 Class 文件都是由 8 字节为单位的字节流组成，所有的 16 位、 32 位和 64 位长度的数
将被构造成 2 个、 4 个和 8 个 8 字节单位来表示 
2、表示Class文件内容的私有数据类型： 
	U1、u2、u4、u8   表示 1、2、4、8个字节的无符号数。
	无符号数 可以用来描述数字、索引引用、数量值或者按照 UTF-8 编码构成的字符串。

     表是 由多个 无符号数 或者其他表 作为数据项构成的符合数据类型。都习惯性一“_info” 结尾。
     表是 用于描述有层次关系的复合结构的数据，整个Class 文件本质上就是一张表。
3、


【访问权限标志】
	access_falgs 是一种掩码标志，用于表示某个类或者接口的访问权限及基础属性。
	access_flag 的取值范围和含义如下：
	标记名 	值 	含义
	ACC_PUBLIC 	0x0001 	可以被包的类外访问。
	ACC_FINAL 	0x0010 	不允许有子类。
	ACC_SUPER 	0x0020	当用到 invokespecial 指令时，需要特殊处理③的父类方法。
	ACC_INTERFACE 	0x0200 	标识定义的是接口而不是类。
	ACC_ABSTRACT 	0x0400 	不能被实例化。
	ACC_SYNTHETIC 	0x1000 	标识并非 Java 源码生成的代码。
	ACC_ANNOTATION 	0x2000 	标识注解类型
	ACC_ENUM 	0x4000 	标识枚举类型
	


【描述符和签名】
1）描述符  ： 是一个描述字段或方法的类型的 字符串
	终止符：
	非终止符
	（+） 表示    一个或多个
	（*）表示     零个或多个
2）签名         ： 用于描述字段、方法和类型定义中的泛型信息的字符串。
		-- 签名（signatures）是用于给Java语言使用的描述信息编码，不在Java虚拟机系统使用的类型中
		-- 泛型类型、方法描述和参数化类型描述等都属于签名（参考Java SE 7规范）
		-- Java 编译器需要这类信息来实现（或辅助实现）反射 和 跟着调试功能。
3）字段描述符(File Descriptor)  ：  是表示一个类、实例、或局部变量的语法符号！
	FieldDescriptor:
		FieldType
	ComponentType:
		FieldType
	FieldType:
		BaseType
		ObjectType
		ArrayType
	BaseType:
		B C D F I J S Z
	ObjectType:
		L Classname ;
	ArrayType:
		[ ComponentType 
	
即：字段描述符的字段类型包含三类（基本类型、对象类型 和 数组类型）。且都是 ASCII 编码的字符。
-- 基本类型的字符解释
字符 	类型 	含义
B 	byte 	有符号字节型数
C 	char 	Unicode 字符， UTF-16 编码
D 	double 	双精度浮点数
F 	float 	单精度浮点数
I 	int 	整型数
J 	long 	长整数
S 	short 	有符号短整数
Z 	boolean 	布尔值 true/false
L Classname; 	reference 	一个名为<Classname>的实例
[ 	reference 	一个一维数组
【例子】
	int  变量 ：            "I"
	java.lang.Object       "Ljava/lang/Object"
	double 数组 d[][]      "[[D"

4）方法描述符
    -- 方法描述符（Method Descriptor）：描述一个方法所需的参数和返回值信息 
	MethodDescriptor:
		( ParameterDescriptor* ) ReturnDescriptor 
    -- 参数描述符（Parameter Descriptor）: 描述需要传给这个方法的参数信息
	ParameterDescriptor:
		FieldType 
    -- 返回值描述符（Retrun Descriptor）: 从当前方法返回的值。
	ReturnDescriptor:
		FieldType
		VoidDescriptor （无返回值，void）

(注：
	1--如果一个方法描述符是有效的，其对应的参数列表总长度小于255
	2-对于实例方法（即类方法）和接口方法，需要额外考虑隐式参数this
	3-参数列表长度的计算规则如下： long 和 double 类参数长度为2，其余都为1。方法列表总长度等于所有参数的长度之和
)
【例子】
	方法  public Object  myThread(int I, double d, Thread t);
	对于描述符为：   (IDLjava/lang/Object;) Ljava/lang/Object;



【常量池】
    1-  通用格式：
	cp_info { u1 tag; u1 info[]; }
	Info 项的内容由tag 的类型决定，tag 的类型如下：
	常量类型 	值
	CONSTANT_Class 	7
	CONSTANT_Fieldref 	9
	CONSTANT_Methodref 	10
	CONSTANT_InterfaceMethodref 	11
	CONSTANT_String 	8
	CONSTANT_Integer 	3
	CONSTANT_Float 	4
	CONSTANT_Long 	5
	CONSTANT_Double 	6
	CONSTANT_NameAndType 	12
	CONSTANT_Utf8 	1
	CONSTANT_MethodHandle 	15
	CONSTANT_MethodType 	16
	CONSTANT_InvokeDynamic 	18

    2-  CONSTANT_Class_info 结构
	CONSTANT_Class_info {
		u1 tag;
		u2 name_index;
	} 
	tag              项的值为  CONSTANT_Class 
	name_index      

    3- CONSTANT_Fieldref_info、 CONSTANT_Methodref_info 、CONSTANT_InterfaceMethodref_info 
	字段，方法和接口方法 由类似的结构表示
	CONSTANT_Fieldref_info {
		u1 tag;
		u2 class_index;
		u2 name_and_type_index;
	} 
	
	CONSTANT_Methodref_info {
		u1 tag;
		u2 class_index;
		u2 name_and_type_index;
	}
	 
	CONSTANT_InterfaceMethodref_info {
		u1 tag;
		u2 class_index;
		u2 name_and_type_index;
	} 
	
    4- CONSTANT_String_info 用于表示 java.lang.String 类型的常量对象 
	CONSTANT_String_info {
		u1 tag;
		u2 string_index;
	} 
	
    5-  CONSTANT_Intrger_info 和 CONSTANT_Float_info 结构表示 4 字节（int 和 float）的数值常量： 
	CONSTANT_Integer_info {
		u1 tag;
		u4 bytes;
	}
	CONSTANT_Float_info {
		u1 tag;
		u4 bytes;
	} 
	【注】理解下 float 和 double 值的表示。
  6-  CONSTANT_Long_info 和 CONSTANT_Double_info 结构表示 8 字节（long 和 double）的数值常量： 
	CONSTANT_Long_info {
		u1 tag;
		u4 high_bytes;
		u4 low_bytes;
	}
	CONSTANT_Double_info {
		u1 tag;
		u4 high_bytes;
		u4 low_bytes;
	} 
	-- class文件的常量池中，所有的8字节的常量都占两个表成员（项）的空间。
	
	
    7- CONSTANT_NameAndType_info 结构用于表示字段或方法 
	CONSTANT_NameAndType_info {
		u1 tag;
		u2 name_index;
		u2 descriptor_index;
	}
	
    8- CONSTANT_Utf8_info 结构用于表示字符串常量的值 
	CONSTANT_Utf8_info {
		u1 tag;
		u2 length;
		u1 bytes[length];
	} 
	
	
    9- CONSTANT_MethodHandle_info 结构用于表示方法句柄，结构如下：
	CONSTANT_MethodHandle_info { 
		u1 tag;
		u1 reference_kind;
		u2 reference_index;
	} 
	
    10- CONSTANT_MethodType_info 结构用于表示方法类型：
	CONSTANT_MethodType_info {
		u1 tag;
		u2 descriptor_index;
	} 
	
   11- CONSTANT_InvokeDynamic_info 
	用于表示 invokedynamic 指令所使用到的引导方法
	（Bootstrap Method）、 引导方法使用到动态调用名称（Dynamic Invocation Name）、 参
	数和请求返回类型、以及可以选择性的附加被称为静态参数（Static Arguments） 的常量序列 
	CONSTANT_InvokeDynamic_info {
		u1 tag;
		u2 bootstrap_method_attr_index;
		u2 name_and_type_index;
	} 
	

【字段】
	每个字段（Field） 都由 field_info 结构所定义，在同一个 Class 文件中，不会有两个字段同时具有相同的字段名和描述符 
	-- 通用格式 
	field_info {
		u2 access_flags;
		u2 name_index;
		u2 descriptor_index;
		u2 attributes_count;
		attribute_info attributes[attributes_count];
	} 
	


【方法】
	method_info 
	所有方法（Method），包括实例初始化方法和类初始化方法（§2.9）在内，都由 method_info
	结构所定义。在一个 Class 文件中，不会有两个方法同时具有相同的方法名和描述符 
	method_info {
		u2 access_flags;
		u2 name_index;
		u2 descriptor_index;
		u2 attributes_count;
		attribute_info attributes[attributes_count];
	} 
	
	-- 方法 access-falgs 标记列表
	标记名 	值 	说明
	ACC_PUBLIC 	0x0001 	public， 方法可以从包外访问
	ACC_PRIVATE 	0x0002 	private， 方法只能本类中访问
	ACC_PROTECTED 	0x0004 	protected， 方法在自身和子类可以访问
	ACC_STATIC 	0x0008 	static， 静态方法
	ACC_FINAL 	0x0010 	final， 方法不能被重写（覆盖）
	ACC_SYNCHRONIZED 	0x0020 	synchronized， 方法由管程同步
	ACC_BRIDGE 	0x0040 	bridge， 方法由编译器产生
	ACC_VARARGS 	0x0080 	表示方法带有变长参数
	ACC_NATIVE 	0x0100 	native， 方法引用非 java 语言的本地方法
	ACC_ABSTRACT 	0x0400 	abstract， 方法没有具体实现
	ACC_STRICT 	0x0800 	strictfp， 方法使用 FP-strict 浮点格式
	ACC_SYNTHETIC 	0x1000 	方法在源文件中不出现，由编译器产生
	


【属性】





【】




















