#pragma once

#include <vector>

#include "Forme.h"

class Chemin: public Forme {
	public:
	Chemin(const std::shared_ptr<Expression> & x1,
		const std::shared_ptr<Expression> & y1) noexcept
	{
		_points = { {x1, y1 } };
	}

	virtual Type type() const noexcept override { return Type::Chemin; }
	std::string to_svg() const override;

	void ajoutePoint(const std::shared_ptr<Expression> & x, const std::shared_ptr<Expression> & y);

	protected:
	Point centre() const override;
};


