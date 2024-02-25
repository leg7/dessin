#pragma once

#include "Forme.h"

class Cercle: public Forme {
	public:
		Cercle(const std::shared_ptr<Expression> & x1,
			const std::shared_ptr<Expression> & y1,
			const std::shared_ptr<Expression> & rayon) noexcept
			: _rayon(rayon) { _points = { {x1, y1} }; }

		virtual Type type() const noexcept override { return Type::Cercle; }
		std::string to_svg() const override;

	protected:
		Point centre() const override;

	private:
		std::shared_ptr<Expression> _rayon;
};
