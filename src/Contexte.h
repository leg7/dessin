#pragma once
#include <map>
#include <string>
#include <memory>
#include "elements/Element.h"

class Contexte
{
	std::map<std::string, std::shared_ptr<Element>> _data;

	public:
	bool add(const std::string &nom, const std::shared_ptr<Element> &e) noexcept;
	bool rm(const std::string &nom) noexcept;
};
