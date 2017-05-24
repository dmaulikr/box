import Foundation
import MetalKit

class MetalRenderManager
{
    private let renderEnconder:MTLRenderCommandEncoder
    private let simplePipelineState:MTLRenderPipelineState
    private let colourPipelineState:MTLRenderPipelineState
    
    init(
        renderEncoder:MTLRenderCommandEncoder,
        simplePipelineState:MTLRenderPipelineState,
        colourPipelineState:MTLRenderPipelineState)
    {
        self.renderEnconder = renderEncoder
        self.simplePipelineState = simplePipelineState
        self.colourPipelineState = colourPipelineState
    }
    
    //MARK: public
    
    func renderSimple(
        vertex:MTLBuffer,
        position:MTLBuffer,
        rotation:MTLBuffer,
        texture:MTLTexture)
    {
        renderEnconder.setRenderPipelineState(simplePipelineState)
        
        renderEnconder.setVertexBuffer(
            vertex,
            offset:0,
            at:MetalConstants.kVertexIndex)
        renderEnconder.setVertexBuffer(
            position,
            offset:0,
            at:MetalConstants.kPositionIndex)
        renderEnconder.setVertexBuffer(
            rotation,
            offset:0,
            at:MetalConstants.kRotationIndex)
        renderEnconder.setFragmentTexture(
            texture,
            at:MetalConstants.kTextureIndex)
        renderEnconder.drawPrimitives(
            type:MetalConstants.kPrimitiveType,
            vertexStart:0,
            vertexCount:MetalConstants.kPrimitiveCount)
    }
    
    func renderColour(
        vertex:MTLBuffer,
        position:MTLBuffer,
        rotation:MTLBuffer,
        texture:MTLTexture)
    {
        renderEnconder.setRenderPipelineState(colourPipelineState)
        
        renderEnconder.setVertexBuffer(
            vertex,
            offset:0,
            at:MetalConstants.kVertexIndex)
        renderEnconder.setVertexBuffer(
            position,
            offset:0,
            at:MetalConstants.kPositionIndex)
        renderEnconder.setVertexBuffer(
            rotation,
            offset:0,
            at:MetalConstants.kRotationIndex)
        renderEnconder.setFragmentTexture(
            texture,
            at:MetalConstants.kTextureIndex)
        renderEnconder.drawPrimitives(
            type:MetalConstants.kPrimitiveType,
            vertexStart:0,
            vertexCount:MetalConstants.kPrimitiveCount)
    }
}
