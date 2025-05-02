local registration_number = tonumber("DDDDDD")

function tvRP.setRegistrationNumber(registration)
	registration_number = registration
end

function tvRP.getRegistrationNumber()
	return registration_number
end 

function tvRP.requestCollision(x,y,z)
	RequestCollisionAtCoord(x,y,z)
end