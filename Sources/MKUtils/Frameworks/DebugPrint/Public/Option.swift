//
// Option.swift
// SwiftPrettyPrint
//
// Created by Yusuke Hosonuma on 2020/12/12.
// Copyright (c) 2020 Yusuke Hosonuma.
//

public extension Debug {
    struct Option {
        var prefix: String?
        var indentSize: Int
        var theme: ColorTheme
        var outputStrategy: OutputStrategy
        var ignoreDeinit: Bool = false

        init(prefix: String? = nil, indentSize: Int = 4, theme: ColorTheme = .default, outputStrategy: OutputStrategy = .print) {
            self.prefix = prefix
            self.indentSize = indentSize
            self.theme = theme
            self.outputStrategy = outputStrategy
        }

        enum OutputStrategy {
            /// using os.log
            case osLog

            /// using print
            case print
        }
    }
}
