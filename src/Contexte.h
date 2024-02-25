#pragma once
#include <map>
#include <string>
#include <memory>
#include "elements/Element.h"
#include "elements/formes/Forme.h"
#include <cstring>

class Contexte
{
	std::map<std::string, std::shared_ptr<Element>> _data;
	size_t _compteurDeFormes[Element::nombreDeFormes];

	public:
	Contexte() { memset(&_compteurDeFormes, 0, Element::nombreDeFormes * sizeof(size_t)); }

	bool add(const std::string &nom, const std::shared_ptr<Element> &e) noexcept;
	bool rm(const std::string &nom) noexcept;
	bool contains(const std::string &key) const noexcept;
	std::shared_ptr<Element> at(const std::string key) const noexcept;
	std::shared_ptr<Forme> atForme(const std::string key) const;

	std::shared_ptr<Forme> getForme(const Element::Type t, const int num) noexcept;
	void addForme(const std::shared_ptr<Forme> &f) noexcept;

	void to_svg() const noexcept;
};

