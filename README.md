=======================================================
## Uso de Random#rand en Ruby:

### 1. rand(n) → devuelve un Integer entre 0 y n-1
    - n debe ser Integer
    - Ejemplo: rand(5) # => 0,1,2,3 o 4

### 2. rand(a..b) → devuelve un Integer dentro del rango a..b
    - a y b son Integer
    - Ejemplo: rand(3..7) # => 3,4,5,6 o 7

### 3. rand() sin argumentos → devuelve un Float entre 0.0 y 1.0 (excluyendo 1.0)
    - Multiplicando por un máximo se obtiene Float en ese rango
    - Ejemplo: rand * 10.0 # => Float entre 0.0 y 10.0

### 4. Consideraciones de tipo:
    - Si quieres Integer y la constante es Float, usar `to_i` + 1
      Ej: rand(MAX_INTELLIGENCE.to_i + 1)
    - Si quieres Float, multiplicar rand por el máximo Float, no hace falta to_f

### 5. Ejemplos aplicados a esta clase:
    - Random Integer: rand(WEAPONS_REWARD + 1)
    - Random Float: rand * MAX_INTELLIGENCE
    
    FUNCIONA MI GITHUB
=======================================================
