


// GetInstrumentByIDSQLiURLParam obtiene un instrumento por ID (VULNERABLE A SQL INJECTION en URL param).
// QueryRowContext only return 1 row. Is not exploitable.
func GetInstrumentByIDSQLiURLParam(ctx context.Context, id string) (*Instrument, error) {
	//id := chi.URLParam(r, "id") will
	// id := r.URL.Query().Get("id") // mario

	var ins Instrument

	// query := fmt.Sprintf("DELETE FROM instruments WHERE id = '%s'", id) // ¡VULNERABLE!
	query := fmt.Sprintf("SELECT id, name, description, price, created_at, updated_at FROM instruments WHERE id = '%s'", id) // ¡VULNERABLE!

	// db vs database

	// Will usa Query(query)

	// Ahora usamos db.DBConn.QueryRow() con las query vulnerable
	err := db.DBConn.QueryRowContext(ctx, query).
		Scan(&ins.ID, &ins.Name, &ins.Description, &ins.Price, &ins.CreatedAt, &ins.UpdatedAt)

	if err != nil {
		// Mensaje genérico
		return nil, fmt.Errorf("instrumento no encontrado o error de base de datos: %w", err)
	}
	return &ins, nil
}



func GetInstrumentByIDSQLiURLParam(ctx context.Context, id string) (*Instrument, error) {

    var ins Instrument

    // 1. Definir la consulta con un MARCADOR DE POSICIÓN (Placeholder)
    // El marcador de posición es '?'. Si usaras PostgreSQL, sería '$1'.
    const query = "SELECT id, name, description, price, created_at, updated_at FROM instruments WHERE id = ?"
    
    // 2. Usar QueryRowContext y pasar el 'id' como un argumento SEPARADO
    // La librería de la base de datos se encarga de escapar y sanitizar el valor 'id'.
    err := db.DBConn.QueryRowContext(ctx, query, id). // ¡SEGURO!
        Scan(&ins.ID, &ins.Name, &ins.Description, &ins.Price, &ins.CreatedAt, &ins.UpdatedAt)

    if err != nil {
        // Manejo de errores (por ejemplo, sql.ErrNoRows)
        if errors.Is(err, sql.ErrNoRows) {
            return nil, fmt.Errorf("instrumento con ID %s no encontrado", id)
        }
        // Mensaje genérico para otros errores de DB
        return nil, fmt.Errorf("error de base de datos al obtener instrumento: %w", err)
    }
    
    return &ins, nil
}



