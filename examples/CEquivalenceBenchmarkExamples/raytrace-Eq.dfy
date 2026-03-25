// oldV.dfy

datatype Vector3D = Vector3DClass(
    x: float,
    y: float,
    z: float
)
datatype Light = LightClass(
    AMBIENT: int,
    DIRECTIONAL: int,
    POINT: int,
    lightType: int,
    lvec: Vector3D,                          
    ir: float,
    ig: float,
    ib: float
)
datatype Surface = SurfaceClass(
    ir: float,
    ig: float,
    ib: float,
    ka: float,
    kd: float,
    ks: float,
    ns: float,
    kt: float,
    kr: float,
    nt: float
)
datatype Sphere = SphereClass(
    surface: Surface,
    center: Vector3D,
    radius: float,
    radSqr: float
)
const var TINY: float := 0.001f;
const var I255: float := 0.00392156f;
Vector3D Vector3DConstructor(float x, float y, float z) {
      Vector3D obj;
      obj.var x := x; obj.y = y; obj.z = z;
      return obj;
}
Vector3D Vector3DConstructor2(Vector3D v) {
    Vector3D obj;
    obj.var x := v.x;
    obj.var y := v.y;
    obj.var z := v.z;
    return obj;
}
Vector3D normalize(Vector3D v){
  var t: float := v.x*v.x + v.y*v.y + v.z*v.z;
  if (t != 0 && t != 1) 
    var t := (float) (1 / sqrt(t));
  v.x *= t;
  v.y *= t;
  v.z *= t;
  return Vector3DConstructor(v.x, v.y, v.z);
}
Light LightConstructor(int type, Vector3D v, float r, float g, float b) {
      Light obj;
      obj.var lightType := type;
      obj.var ir := r;
      obj.var ig := g;
      obj.var ib := b;
      if (type != obj.AMBIENT) {
            obj.var lvec := v;
          if (type == obj.DIRECTIONAL) {
                obj.var lvec := normalize(obj.lvec);
            }
      }
      return obj;
}
Surface SurfaceConstructor(float rval, float gval, float bval, float a, float d, float s, float n, float r, float t, float index){
      Surface obj;
      obj.var ir := rval; obj.ig = gval; obj.ib = bval;
      obj.var ka := a; obj.kd = d; obj.ks = s; obj.ns = n;
      obj.var kr := r*I255; obj.kt = t; obj.nt = index;
      return obj;
}
Sphere SphereConstructor(Surface s, Vector3D c, float r) {
		  Sphere obj;
	    obj.var surface := s;
	    obj.var center := c;
	    obj.var radius := r;
      obj.var radSqr := r*r;
		  return obj;
}
method intersect(s: Sphere, d: Sphere) returns (res: bool) {
  var dx: float := s.center.x - d.center.x;
  var dy: float := s.center.y - d.center.y;
  var dz: float := s.center.z - d.center.z;
  var t: float := s.radSqr - dx*dx - dy*dy - dz*dz;
  if (t < 0)
    return false;
  var t := (float) sqrt(t);
  if (t < 0)
    return false;
  return true;
}
// newV.dfy

datatype Vector3D = Vector3DClass(
    x: float,
    y: float,
    z: float
)
datatype Light = LightClass(
    AMBIENT: int,
    DIRECTIONAL: int,
    POINT: int,
    lightType: int,
    lvec: Vector3D,                          
    ir: float,
    ig: float,
    ib: float
)
datatype Surface = SurfaceClass(
    ir: float,
    ig: float,
    ib: float,
    ka: float,
    kd: float,
    ks: float,
    ns: float,
    kt: float,
    kr: float,
    nt: float
)
datatype Sphere = SphereClass(
    surface: Surface,
    center: Vector3D,
    radius: float,
    radSqr: float
)
const var TINY: float := 0.001f;
const var I255: float := 0.00392156f;
Vector3D Vector3DConstructor(float x, float y, float z) {
      Vector3D obj;
      obj.var x := x; obj.y = y; obj.z = z;
      return obj;
}
Vector3D Vector3DConstructor2(Vector3D v) {
    Vector3D obj;
    obj.var x := v.x;
    obj.var y := v.y;
    obj.var z := v.z;
    return obj;
}
Vector3D normalize(Vector3D v){
  var t: float := v.x*v.x + v.y*v.y + v.z*v.z;
  if (t != 0 && t != 1) 
    var t := (float) (1 / sqrt(t));
  v.x *= t;
  v.y *= t;
  v.z *= t;
  var t := v.x*v.x;//change
  return Vector3DConstructor(v.x, v.y, v.z);
}
Light LightConstructor(int type, Vector3D v, float r, float g, float b) {
      Light obj;
      obj.var lightType := type;
      obj.var ir := r;
      obj.var ig := g;
      obj.var ib := b;
      if (obj.lightType != obj.AMBIENT) {//change
            obj.var lvec := v;
          if (type == obj.DIRECTIONAL) {
                obj.var lvec := normalize(obj.lvec);
            }
      }
      return obj;
}
Surface SurfaceConstructor(float rval, float gval, float bval, float a, float d, float s, float n, float r, float t, float index){
      Surface obj;
      obj.var ir := rval; obj.ig = gval; obj.ib = bval;
      obj.var ka := a; obj.kd = d; obj.ks = s; obj.ns = n;
      obj.var kr := r*I255; obj.kt = t; obj.nt = index;
      return obj;
}
Sphere SphereConstructor(Surface s, Vector3D c, float r) {
		  Sphere obj;
	    obj.var surface := s;
	    obj.var center := c;
	    obj.var radius := r;
      var temp: float := r*r;//change
      obj.var radSqr := temp;//change
		  return obj;
}
method intersect(s: Sphere, d: Sphere) returns (res: bool) {
  var dxRenamed: float := s.center.x - d.center.x;//change
  var dy: float := s.center.y - d.center.y;
  var dz: float := s.center.z - d.center.z;
  var t: float := s.radSqr - dxRenamed*dxRenamed - dy*dy - dz*dz;//change
  if (t < 0)
    return false;
  var t := (float) sqrt(t);
  if (t < 0)
    return false;
  return true;
}