extends CharacterBody2D


# returns the position of the connector marker to add the next piece in line dynamicly
func get_connector_position() -> Vector2:
	return %connector.global_position
