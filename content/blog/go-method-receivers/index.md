---
title: "Go lang method receivers value vs reference"
weight: 1
draft: false
description: "Understanding Method Receivers in Go: Value vs. Pointer Receivers"
tags: ["go", "pointers"]
# series: ["Documentation"]
series_order: 4
---

# Understanding Method Receivers in Go: Value vs. Pointer Receivers

In the Go programming language, methods can have **receivers**, which determine how methods are called on types. A common question among Go developers is: _What’s the difference between value receivers and pointer receivers?_ and _Which one should I use?_ In this blog, we’ll break down the differences, use cases, and best practices for method receivers in Go.

---

## What Are Method Receivers in Go?

Method receivers define how methods are associated with types in Go. You can declare methods with **value receivers** or **pointer receivers**, and your choice affects how methods interact with the underlying struct.

### Value Receiver

- Operates on a **copy** of the struct.
- Changes made inside the method do **not** affect the original object.
- Ideal for **small structs** or **immutable operations**.

#### Example

```go
package main
import "fmt"
type User struct {
  Name string
}
func (u User) SetName(name string) {
  u.Name = name // Modifies a copy, not the original
}
func main() {
  user := User{Name: "Alice"}
  user.SetName("Bob")
  fmt.Println(user.Name) // Outputs: Alice (unchanged)-
}
```

Why?\* Because Go passes a **copy** of `user` to `SetName()`, the original remains unchanged.

---

### Pointer Receiver

- Operates on a **pointer**, meaning it modifies the **original struct**.
- More efficient for **large structs**, as it avoids copying.
- Required for **methods that update the struct's fields**.

#### Example

```go
package main
import "fmt"
type User struct {
  Name string
}
func (u *User) SetName(name string) {
  u.Name = name // Modifies the original
}
func main() {
  user := User{Name: "Alice"}
  user.SetName("Bob")
  fmt.Println(user.Name) // Outputs: Bob (changed)
}
```

Why?\* The method receives a **pointer** to `user`, so it directly modifies the original object.

---

### Can One Method Work for Both?

**Yes!** Methods with **pointer receivers** can be called on both **pointers and values**, thanks to **Go’s automatic pointer conversion**.

#### Example

```go
package main
import "fmt"
type User struct {
Name string
}
// Pointer receiver works with both values and pointers
func (u *User) SetName(name string) {
u.Name = name
}
func main() {
user1 := User{Name: "Alice"}
user2 := &User{Name: "Eve"}
user1.SetName("Bob") // Value used
user2.SetName("Charlie") // Pointer used
fmt.Println(user1.Name) // Bob
fmt.Println(user2.Name) // Charlie
}
```

Key Insight:\* Pointer receivers are **more flexible**, but value receivers are valuable for specific use cases.

---

## When to Use Value vs. Pointer Receivers

| **Use Case**                        | **Receiver Type** |
| ----------------------------------- | ----------------- |
| **Modifies internal state**         | Pointer (`*T`)    |
| **Efficient for large structs**     | Pointer (`*T`)    |
| **Works with both value & pointer** | Pointer (`*T`)    |
| **Immutable operations**            | Value (`T`)       |
| **Small structs**                   | Value (`T`)       |
| **Struct used as map key**          | Value (`T`)       |

---

### Interface Compatibility Pitfall

If you use **pointer receivers**, only **pointer instances** satisfy the interface. With **value receivers**, both **value and pointer instances** work.

#### Example

```go
package main
import "fmt"
type Stringer interface {
  String() string
}
type Data struct {
  Value string
}
// Value receiver implements interface for both values and pointers
func (d Data) String() string {
  return d.Value
}
func main() {
  d := Data{"Hello"}
  var s Stringer = d // Works with value
  fmt.Println(s.String())
  var sp Stringer = &d // Works with pointer
  fmt.Println(sp.String())
}
```

Takeaway:\* Use **value receivers** when the type might be used with interfaces.

---

## Conclusion

- ✅ **Value receivers:** Great for **small, immutable operations** and **interface compatibility**.
- ✅ **Pointer receivers:** Best for **modifying internal state** and **large structs**.
- ✅ Use **pointer receivers** if you’re unsure—they're more flexible and efficient for most cases.
  Mastering method receivers is essential for writing **clean, efficient, and idiomatic Go code**. Happy coding! 🚀✨
