// RUN: %dxc -E main -T ps_6_0  -not_use_legacy_cbuf_load %s | FileCheck %s

// The shift for hlsl only use the LSB 5 bits (0-31 range) of src1 for int/uint.
// CHECK: shl i32
// CHECK: 18
// CHECK: ashr
// CHECK: lshr

// The shift for hlsl only use the LSB 6 bits (0-63 range) of src1 for int64_t/uint64_t.
// CHECK: shl i64
// CHECK: 4
// CHECK: lshr
// CHECK: ashr

uint64_t u;
int64_t i;

float4 main(float4 a : A, int b:B, int c:C, uint d:D) : SV_TARGET {
  int e = b << 50;
  e = e >> c;
  uint f = d >> e;
  uint64_t x = u << 68;
  x = x >> c;
  int64_t z = i >> d;
  return a + f + x + z;
}