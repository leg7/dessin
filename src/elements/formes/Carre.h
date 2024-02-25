#pragma once

#include "Forme.h"

class Carre: public Forme {
	public:
		Carre(const std::shared_ptr<Expression> &x1,
			const std::shared_ptr<Expression> &y1,
			const std::shared_ptr<Expression> &taille) noexcept
			: _taille(taille) { _points = { {x1, y1} }; }

		virtual Type type() const noexcept override { return Type::Carre; }
		virtual void recevoirMessage(const messageSetPropriete &m) override;
		std::string to_svg() const override;

		std::shared_ptr<Expression> _taille;
		Point centre() const override;
};
